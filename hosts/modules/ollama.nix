{...}: {
  services.ollama = {
    enable = true;
    port = 11434;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };

  services.open-webui.enable = false;
}
