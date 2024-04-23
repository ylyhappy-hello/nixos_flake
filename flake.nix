{
  description = "My Awesome System Config of Doom";
  outputs = inputs@{ self, nixpkgs, nixos-generators, nixos-wsl, st, kbcli, idea, goland
    , nur, home-manager, ... }:
    let
      selfPkgs = import ./pkgs;
      system = "x86_64-linux";
      user = { laptop_no_nvidia = "yly_no_nvidia"; };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          #cudaSupport = true;
          permittedInsecurePackages =
            [  "electron-19.1.9" "electron-12.2.3" "nodejs-14.21.3" "openssl-1.1.1u" ];
        };
        overlays = [
          self.overlays.default
          st.overlays.default
          idea.overlays.default
          goland.overlays.default
          # nixd.overlays.default 
        ] ++ (import ./overlays);
        # ];
      };
      lib = nixpkgs.lib;
    in {
      overlays.default = selfPkgs.overlay;
      nixosConfigurations = {
        laptop_no_nvidia = lib.nixosSystem 
          (import ./hosts { buildISO=false; buildWSL=false;inherit system pkgs user inputs self lib nixos-wsl; });

        laptop_wsl = lib.nixosSystem 
          (import ./hosts { buildISO=true;  buildWSL=true; inherit system pkgs user inputs self lib nixos-wsl; });
      };
      packages.x86_64-linux.default =
        nixos-generators.nixosGenerate ({ format = "install-iso"; }
        // (import ./hosts { buildISO=true; buildWSL=false;inherit system pkgs user inputs self lib nixos-wsl; }));
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    # hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    # joshuto.url = "github:kamiyaa/joshuto";
    # picom.url = "github:yaocccc/picom";
    kbcli.url = "github:ylyhappy-hello/kbcli";
    idea.url = "github:ylyhappy-hello/idea-overlay";
    goland.url = "github:ylyhappy-hello/goland-overlay";
    st.url = "github:ylyhappy-hello/st";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/2311.5.3";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
