{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [ 
    virt-manager 
    spice
    win-spice
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  programs.dconf.enable = true;
  services.spice-vdagentd.enable = true;
}
