return {
    settings = {
        nixd = {
            nixpkgs = { expr = "import <nixpkgs> { }" },
            formatting = { command = { "alejandra" } },
            options = {
                nixos = { expr = '(builtins.getFlake (toString ~/.config/nixos)).nixosConfigurations.Sentinel.options' },
                home_manager = { expr = '(builtins.getFlake (toString ~/.config/nixos)).homeConfigurations.pencelheimer.options' }
            },
        }
    }
}
