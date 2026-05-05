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
    modelsDir = "/var/lib/llama-cpp/models";
    extraFlags = [
      "--jinja"
    ];
  };

  systemd.services.llama-cpp.serviceConfig = {
    BindReadOnlyPaths = [ "/home/pencelheimer/models:/var/lib/llama-cpp/models" ];
  };
}
