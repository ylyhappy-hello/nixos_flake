{ pkgs, ... }: {
  services = {
    nginx = {
      enable = true;
      virtualHosts = {
        demo = {
          listen = [
            { addr = "127.0.0.1"; port = 80; } 
            #{ addr = "[0.0.0.0]"; port = 443; ssl = true; }
          ];
          locations."/".root = "${./index.html}";
        };
      };
    };
  };
}

