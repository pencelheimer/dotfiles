{...}: {
  services.ollama = {
    enable = false;
    port = 11434;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };

  services.open-webui.enable = false;

  services.llama-cpp = {
    enable = true;
    port = 7070;
    # modelsDir = ../../llm-models;
    extraFlags = [
      "--jinja"
      "-c 65536"
    ];
  };
}
