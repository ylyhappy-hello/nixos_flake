{ config, buildWSL, pkgs, user, inputs, lib, ... }:
let
  bootConfig = (if buildWSL then
    { }
  else {
    supportedFilesystems = [ "ntfs" "fat32" "ext4" "exfat" "btrfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = lib.mkForce true;
        useOSProber = false;
        device = "nodev";
        efiSupport = true;
        extraEntries = "";
        configurationLimit = 25;
        theme = pkgs.distro-grub-theme;
      };
      timeout = 10;
    };
    kernelParams = [ "quiet" "splash" "nvidia-drm.modeset=1" ];
    # consoleLogLevel = 0;
    # initrd.verbose = false;
    initrd.network.ssh.enable = true;
  });
in {
  imports = (import ../../../modules/virtualisation)
    ++ (import ../../../modules/editors) ++ (import ../../../modules/shell)
    ++ (import ../../../modules/develop) ++ [
      ../../../modules/develop/python
      ../hardware-configuration.nix
      ../../../modules/fonts
      ../../../modules/environment/nixos.nix
      # ../../../modules/shell/zsh/zsh_patch.nix
    ] ++ [ ../../../modules/desktop/kde ];
  users.mutableUsers = false;
  users.users.root = {
    initialHashedPassword = lib.mkForce
      "$6$MHD44lZkFNlW9/xd$SO8ZIZB/jRtT1T86IjdEZ8PNfEKErDguozNeC.5LDk9yz0UJPz4gy1QGUIPBKmYVil7m0c76oeWnSkbZLThYK/";
  };
  users.users.${user} = {
    initialHashedPassword =
      "$6$MHD44lZkFNlW9/xd$SO8ZIZB/jRtT1T86IjdEZ8PNfEKErDguozNeC.5LDk9yz0UJPz4gy1QGUIPBKmYVil7m0c76oeWnSkbZLThYK/";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "networkmanager"
      "network"
      "wheel"
      "video"
      "libvirt"
      "docker"
      "vboxusers"
    ];
    openssh.authorizedKeys.keys = [ ];
    packages = (with pkgs; [
      # tdesktop
      latest-qq
      yacd
      etcher
      kubectl
      kubernetes
      kubernetes-helm
      kbcli
      minikube
      apifox
      navicat
      libsForQt5.qtstyleplugin-kvantum
      gimp
      qbittorrent
      meld
      yazi
      nomacs
      mpv
      # wpsoffice-cn
      # feishu
      # thunderbird
      # blender
      # dbeaver
      # aichat
    ]) ++ (with config.nur.repos;
      [
        # linyinfeng.icalingua-plus-plus
        # linyinfeng.wemeet
      ]);
  };
  boot = bootConfig;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
    ];
  };
  environment = {
    variables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };
    systemPackages = with pkgs; [
      libnotify
      xclip
      xorg.xrandr
      # cinnamon.nemo
      polkit_gnome
      networkmanagerapplet
      xorg.xev
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      # grim
      # pkgs.rust-bin.stable.latest.default
      # lxappearance
      imagemagick
      flameshot
      clash-meta
      yacd
      # etcher
      mpc-qt
      gparted
    ];
  };

  services.xserver = { xkbOptions = "caps:escape"; };
  console.useXkbConfig = true;

  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services = { gvfs.enable = true; };
}
