{user, pkgs, ...}:
let 
  clash-init = pkgs.writeShellScriptBin "clash-init" ''
    mkdir -p /home/${user}/.config/clash 
    rm -rf /home/${user}/.local/jdtls-config
    cp ${pkgs.jdt-language-server}/share/config /home/${user}/.local/jdtls-config/ -r
    chmod +w /home/${user}/.local/jdtls-config
  '';
in
{
  environment.systemPackages = with pkgs; [clash-meta clash-verge];
  systemd.services.clash = {
    description = "auto started clash";
    serviceConfig.ExecStart = ''
    ${pkgs.clash-meta}/bin/clash-meta
    '';
    wantedBy = ["multi-user.target"];
  };
}
