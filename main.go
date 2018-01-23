package main

import (
	"flag"
	"fmt"

	"github.com/rmikehodges/SneakyVulture/google"
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
  -rh             Restrict proxying requests to this header (Not functional)
`
)

func main() {
	projectName := flag.String("pn", "", "")
	projectDir := flag.String("pd", "./gae", "")
	restrictedUA := flag.String("ru", "", "")
	restrictedSubnet := flag.String("rs", "", "")
	restrictedHeader := flag.String("rh", "", "")
	defaulRedirect := flag.String("dr", "https://google.com", "")
	c2url := flag.String("c2", "", "")
	newProject := flag.Bool("new", false, "")
	flag.Usage = func() {
		fmt.Println(usage)
	}
	flag.Parse()

	result, url := google.CreateRedirector(*projectName, *restrictedUA, *restrictedSubnet, *restrictedHeader,
		*defaulRedirect, *c2url, *newProject, *projectDir)
	if result {
		fmt.Println(url)
	} else {
		fmt.Println("Something went wrong")
	}
}
