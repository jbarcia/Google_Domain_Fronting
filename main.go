package main

import (
	"flag"
	"fmt"

	"github.com/rmikehodges/hideNsneak/google"
)

const (
	usage = `
Creates a Go reverse proxy using the given options and deploys it to google app engine

Usage:
  gaeDeploy [options]
Options:
  -pn             ProjectID to use
  --new           Flag to specify if a new project ID needs to be created
  -pd             Directory where the project files reside (Default: ./gae)
  -c2             C2 URL that the reverse proxy will point to i.e. http://c2server.com
  -dr             Default redirect that will occur if a restricted condition is not met (Default: https://google.com)
  -rs             Restrict proxying requests to this subnet
  -ru             Restrict proxying requests to this User Agent
  -rh             Restrict proxying requests to this header name
  -rv			  Restrict proxying requests to this header value
`
)

//TODO: Make C2 Profile Writing Better
func main() {
	projectName := flag.String("pn", "", "")
	projectDir := flag.String("pd", "./gae", "")
	restrictedUA := flag.String("ru", "", "")
	restrictedSubnet := flag.String("rs", "", "")
	restrictedHeader := flag.String("rh", "", "")
	defaulRedirect := flag.String("dr", "https://google.com", "")
	c2url := flag.String("c2", "", "")
	newProject := flag.Bool("new", false, "")
	c2profile := flag.String("cp", "", "")
	c2out := flag.String("co", *c2profile+"2", "")
	keystore := flag.String("ks", "", "")
	keystorePass := flag.String("kp", "", "")
	flag.Usage = func() {
		fmt.Println(usage)
	}
	flag.Parse()

	result, url := google.CreateRedirector(*projectName, *restrictedUA, *restrictedSubnet, *restrictedHeader,
		*defaulRedirect, *c2url, *newProject, *projectDir, *c2profile, *c2out, *keystore, *keystorePass)
	if result {
		fmt.Println(url)
	} else {
		fmt.Println("Something went wrong - Look Above")
	}
}
