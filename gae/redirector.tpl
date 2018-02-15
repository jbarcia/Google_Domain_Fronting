package goengine

import (
	"net"
	"net/http"
	"net/url"

	"github.com/rmikehodges/gaereverseproxy"
)

type Prox struct {
	// target url of reverse proxy
	target *url.URL
	// instance of Go ReverseProxy thatwill do the job for us
	proxy *gaereverseproxy.ReverseProxy
}

func validUA(userAgent string) bool {
	ua := "{{.RestrictedUA}}"
	if ua != "" && ua != userAgent {
		return false
	}
	return true
}

func validIP(remoteIP string) bool {
	subnet := "{{.RestrictedSubnet}}"
	if len(subnet) > 8 {
		_, cidr, err := net.ParseCIDR(subnet)
		if err != nil {
			return false
		}
		if !cidr.Contains(net.ParseIP(remoteIP)) {
			return false
		}
	}
	return true
}

//TODO: Add header templating
func validHeader(remoteHeader http.Header) bool {
	header, value := "{{.HeaderName}}", "{{.HeaderValue}}"
	if header != "" && value != "" {
		if remoteHeader.Get(header) != value {
			return false
		}
	}
	return true
}

// small factory
func New(target string) *Prox {
	url, _ := url.Parse(target)
	// you should handle error on parsing
	return &Prox{target: url, proxy: gaereverseproxy.NewSingleHostReverseProxy(url)}
}

func (p *Prox) handle(w http.ResponseWriter, r *http.Request) {
	// call to magic method from ReverseProxy object
	if !validUA(r.UserAgent()) || !validIP(r.RemoteAddr) || !validHeader(r.Header) {
		http.Redirect(w, r, "{{.DefaultRedirect}}", 301)
	} else {
		p.proxy.ServeHTTP(w, r)
	}
}

func init() {
	proxy := New("{{.C2Url}}")

	// server
	http.HandleFunc("/", proxy.handle)
}