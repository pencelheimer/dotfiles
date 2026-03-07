{
  lib,
  config,
  ...
}: {
  imports = [
    ./git.nix
    ./neovim.nix
    ./yazi.nix
    ./zellij.nix
    ./tmux.nix
    ./direnv.nix
    ./ssh.nix
    ./opencode.nix

    ./terminal
    ./shell
  ];

  options.dev = {
    enable = lib.mkEnableOption "dev environment";
  };

  config = lib.mkIf config.dev.enable {
    dev = {
      git.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      zellij.enable = lib.mkDefault false;
      tmux.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;

      terminal.kitty.enable = true;

      shell.fish.enable = lib.mkDefault true;
      shell.extras = {
        enable = lib.mkDefault true;
        use-eza = lib.mkDefault true;
      };
    };
  };
}
