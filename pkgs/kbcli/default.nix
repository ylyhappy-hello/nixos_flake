{ fetchurl, stdenv, lib, appimageTools, pkgs, callPackage, ... }:
stdenv.mkDerivation rec {
  name = "kbcli";
  version = "0.8.2";
  src = pkgs.fetchzip {
    url =
      "https://github.com/apecloud/kbcli/releases/download/v${version}/kbcli-linux-amd64-v${version}.tar.gz";
    hash = "sha256-lZWSxXap88+Gw69vQm3EEpc/Ed+B0GXdX7i+3OoDOqI=";
  };
  installPhase = ''
    install -m555 -D $src/kbcli $out/bin/kbcli
  '';
  meta = with lib; {
    description = "多连接数据库开发工具";
    longDescription = ''
      Navicat Premium 是一套多连接数据库开发工具，让你在单一应用程序中同时连接多种类型的数据库：MySQL、Redis、MariaDB、MongoDB、SQL Server、SQLite、Oracle 和 PostgreSQL，可一次快速方便地访问所有数据库。了解更多 >
    '';
    homepage = "https://www.navicat.com.cn/products";
    # license = licenses.gpl3Plus;
    # maintainers = [ maintainers.eelco ];
    # platforms = platforms.all;
  };
}
