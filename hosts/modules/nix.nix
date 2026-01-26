{inputs, ...}: {
  imports = [];

  options = {};

  config = {
    nixpkgs.config.allowUnfree = true;

    nix = {
      # package = pkgs.lixPackageSets.latest.lix;

      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      settings.extra-substituters = [
        "https://yazi.cachix.org"
        "https://walker.cachix.org"
        "https://chaotic-nyx.cachix.org/"
        "https://cosmic.cachix.org/"
        "https://nix-community.cachix.org/"
        "https://devenv.cachix.org"
      ];

      settings.extra-trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
