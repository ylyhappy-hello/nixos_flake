{pkgs, ...}:{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans
    wqy_zenhei
    ttf-wps-fonts
    (nerdfonts.override { fonts = [ "OpenDyslexic" "Iosevka" ]; })
    ( (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }).overrideAttrs (oldAttrs: { version = "2.3.2"; } ) )
  ];
}
