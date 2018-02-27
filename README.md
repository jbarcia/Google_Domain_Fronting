# Google Domain Fronting

Creates a Go reverse proxy using the given options and deploys it to google app engine

Usage: gaeDeploy [options]<br>
Options:<br>
  -pn             ProjectID to use<br>
  --new           Flag to specify if a new project ID needs to be created<br> 
  -pd             Directory where the project files reside (Default: ./gae)<br>
  -c2             C2 URL that the reverse proxy will point to i.e. http://c2server.com<br>
  -dr             Default redirect that will occur if a restricted condition is not met (Default: https://google.com)<br> 
  -rs             Restrict proxying requests to this subnet<br> 
  -ru             Restrict proxying requests to this User Agent<br> 
  -rh             Restrict proxying requests to this header (Not functional)<br> 
