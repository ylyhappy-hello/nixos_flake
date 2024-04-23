{ config, pkgs, inputs, lib, ... }:

{
  imports = (import ../modules/service);
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;
  time.timeZone = "Asia/Shanghai";
  # i18n.defaultLocale = "en_US.UTF-8";
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.extraConfig = ''
    PubkeyAuthentication yes
  '';
  networking.firewall.enable = false;
  networking.proxy.default = "http://127.0.0.1:7888";
  networking.proxy.noProxy = "127.0.0.1,localhost,work.com";
  nix = {
    settings = {
      trusted-substituters = [
       # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      substituters = [
       # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      auto-optimise-store = true; # Optimise syslinks
      trusted-users = [ "root" "@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  services.dbus.enable = true;
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      neovim
      wget
      neofetch
      eza
      gcc
      # clang
      # cargo
      # zig
      # p7zip
      # atool
      # unzip
      appimage-run
      gnome.gnome-keyring
      ffmpeg
      ffmpegthumbnailer
      glib
      xdg-utils
      pciutils
      gdb
      killall
      nodejs
      socat
      zip
      rar
      frp
      # sops
    ];
  };
  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-23.11";
    };
    stateVersion = "23.11";
  };
}
