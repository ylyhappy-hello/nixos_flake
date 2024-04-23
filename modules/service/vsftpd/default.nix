{ pkgs, user, ... }: {
  # pkgs.libselinux
  environment.systemPackages = [ pkgs.inetutils ];
  services.vsftpd = {
    enable = true;
    writeEnable = true;
    anonymousUser = true;
    anonymousUmask = "022";
    anonymousMkdirEnable = true;
    anonymousUploadEnable = true;
    anonymousUserHome = "/home/${user}/ftp";
    localRoot = "/var/www/${user}";
    extraConfig = "\nanon_other_write_enable=YES\n    ";
  };
}
