{ fetchurl, lib, stdenv, }:

stdenv.mkDerivation rec {
  pname = "yacd";
  version = "v0.3.8";
  src = fetchurl {
    url =
      "https://github.com/haishanh/yacd/releases/download/v0.3.8/yacd.tar.xz";
    sha256 = "sha256-1dfs3pGnCKeThhFnU+MqWfMsjLjuyA3tVsOrlOURulA=";
  };

  installPhase = ''
    cp -r . $out
  '';

  meta = with lib; {
    homepage = "https://github.com/haishanh/yacd";
    description = "Yet Another Clash Dashboard";
    license = licenses.mit;
    maintainers = with maintainers; [ yinfeng ];
  };
}
