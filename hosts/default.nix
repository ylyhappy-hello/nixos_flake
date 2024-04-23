{ system, self, pkgs, buildISO, buildWSL, nixos-wsl, user, lib, inputs, ... }:
let desktop = "x11";
in {
  inherit system pkgs;
  specialArgs = {
    inherit inputs buildWSL;
    user = user.laptop_no_nvidia;
  };
  modules = [
    (if buildISO then ./laptop_no_nvidia/buildios.nix else ./laptop_no_nvidia/hardware-configuration.nix)
    ./laptop_no_nvidia/${desktop}
  ] ++ [ ./system.nix ] ++
  (if buildWSL then [
    nixos-wsl.nixosModules.default
    {
      wsl.enable = true;
    }
  ] else [])
  ++ [
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { user = user.laptop_no_nvidia; };
        users.${user.laptop_no_nvidia} = {
          imports = [ (import ./laptop_no_nvidia/${desktop}/home.nix) ] ++ [ ];
        };
      };
      nixpkgs = { overlays = [ self.overlays.default ]; };
    }
  ];
}
