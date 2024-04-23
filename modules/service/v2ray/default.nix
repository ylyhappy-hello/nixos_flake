{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    v2ray v2raya v2ray-geoip qv2ray xray
  ];
}
