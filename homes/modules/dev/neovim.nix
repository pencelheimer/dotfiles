{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options.dev.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.dev.neovim.enable {
    stylix.targets.neovim.enable = false;

    xdg.configFile."nvim" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/pencelheimer/.config/nixos/raw/nvim";
    };

    home.sessionVariables = {
      "MANPAGER" = "nvim +Man!";
      "CODELLDB_PATH" = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      "LIBLLDB_PATH" = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so";
    };

    programs.neovim = {
      enable = true;
      withPython3 = false;
      withRuby = false;
      defaultEditor = true;
      sideloadInitLua = true;

      # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

      extraPackages = with pkgs; [
        # lsps
        bash-language-server
        clang-tools
        emmet-language-server
        vscode-json-languageserver
        gopls
        hyprls
        lua-language-server
        nixd
        nil
        basedpyright
        taplo
        tinymist
        gopls
        just-lsp
        rust-analyzer
        postgres-language-server
        jdt-language-server
        protols
        typescript-language-server
        lspmux

        # formatters
        alejandra
        black
        rustfmt

        # linters
        clippy

        # debuggers
        delve
        lldb

        # other
        tree-sitter # needed for TreeSitter grammars
        gcc # needed for TreeSitter grammars
        rustc # needed for rust-analyzer std hints
        glibc # needed for lldb
        nodejs # needed for makrdown preview plugin
        xdg-utils # for opening files
      ];
    };
  };
}
