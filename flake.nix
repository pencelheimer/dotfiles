{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi = {
      url = "github:sxyazi/yazi";
    };

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:vikingnope/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    pencelheimer-home = ./homes/pencelheimer/home.nix;
    pencelheimer-overlays = [
      inputs.yazi.overlays.default
    ];
  in {
    nixosConfigurations."Sentinel" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        hostName = "Sentinel";
        userName = "pencelheimer";
      };

      modules = [
        ./hosts/Sentinel/configuration.nix

        home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s

        {
          home-manager.users.pencelheimer = pencelheimer-home;
          home-manager.backupFileExtension = "HM_BACKUP";
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
        {nixpkgs.overlays = pencelheimer-overlays;}
      ];
    };

    homeConfigurations."pencelheimer" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {inherit inputs;};

      modules = [
        pencelheimer-home
        {nixpkgs.overlays = pencelheimer-overlays;}

        inputs.stylix.homeModules.stylix
        inputs.niri.homeModules.niri
      ];
    };
  };
}
