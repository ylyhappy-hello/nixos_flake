{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "ttf-wps-fonts";
  version = "0.0.1";
  src = pkgs.fetchgit {
    url = "https://github.com/BannedPatriot/ttf-wps-fonts";
    hash = "sha256-oRVREnE3qsk4gl1W0yFC11bHr+cmuOJe9Ah+0Csplq8=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/ttf-wps-fonts/ ./*.ttf
    runHook postInstall
  '';
  meta = with pkgs.lib; {
    homepage = "https://github.com/BannedPatriot/ttf-wps-fonts";
    description = "These are the symbol fonts required by wps-office."; 
    # license = licenses.ofl;
    platforms = platforms.all;
    # maintainers = with maintainers; [ demize dtzWill ];
  };
}
