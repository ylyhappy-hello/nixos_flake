{ pkgs, user, ...}: {
  services.httpd.enable = true;
  services.httpd.adminAddr = "localhost";
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.httpd.extraModules = [
    # note that order is *super* important here
    {
      name = "dav_svn";
      path = "${pkgs.apacheHttpdPackages.subversion}/modules/mod_dav_svn.so";
    }
    {
      name = "authz_svn";
      path = "${pkgs.apacheHttpdPackages.subversion}/modules/mod_authz_svn.so";
    }
  ];

  services.httpd.virtualHosts = {
    "svn" = {
      hostName = ''nixos'';
      documentRoot = /home/${user}/svn;
      locations."/svn".extraConfig = ''
        DAV svn
        SVNParentPath REPO_PARENT
        AuthzSVNAccessFile ACCESS_FILE
        AuthName "SVN Repositories"
        AuthType Basic
        AuthUserFile PASSWORD_FILE
        Require valid-user
      '';
    };
  };
}

