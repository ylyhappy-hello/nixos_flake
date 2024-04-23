{ config, lib, inputs, user, pkgs, ... }:
let 
  yup = pkgs.writeShellScriptBin "yup" ''
  sudo mount /dev/nvme0n1p1 /boot
  cd $HOME/Desktop/nixos_config_flake
  git add -A
  sudo -E nixos-rebuild switch --flake .#laptop_no_nvidia --impure
  '';
in 
{
  environment.systemPackages = [ yup ];
}
