{ inputs, pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "yly_no_nvidia";
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "materia-dark";
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
  hardware.opengl.extraPackages = with pkgs; [ intel-compute-runtime ];

  environment.systemPackages = with pkgs; [
    materia-kde-theme
    st
    rofi
    lsof
    acpi
    filezilla
    gnumake
    cmake
    picom
    #obsidian
    pcmanfm
    tree
    #ocamlPackages.gstreamer
    rustc
    cargo
    libsForQt5.qt5.qtgraphicaleffects
  ];
  services.xserver.windowManager.dwm.package = pkgs.yly-dwm;
  services.xserver.windowManager.dwm.enable = true;
}
