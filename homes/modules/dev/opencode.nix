{
  config,
  lib,
  ...
}: {
  imports = [];
  options.dev.opencode = {
    enable = lib.mkEnableOption "opencode";
  };
  config = lib.mkIf config.dev.opencode.enable {
    programs.opencode = {
      enable = true;
      settings = {
        provider.ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options.baseURL = "http://localhost:11434/v1";
          models = {
            "qwen3:4b-instruct-2507-q4_K_M".name = "qwen3:4b-instruct";
          };
        };
      };
    };
  };
}
