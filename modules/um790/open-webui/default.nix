{pkgs, ...}:
{
  services.open-webui = {
    enable = true;
    host = "100.112.119.112";
    package = pkgs.open-webui;
    port = 8081;
   # environment = {
   #   OLLAMA_API_BASE_URL= "http://ollama.say.id";
   # };
  };
  services.nginx.virtualHosts."chat.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:8081";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 10000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan;
    model = "/home/sayid/models/gpt-oss-20b-F16.gguf";
    port = 11435;
    host = "0.0.0.0";
    extraFlags = [
      "--jinja"
      "-ngl" "24" # offload 8 layers to GPU
      "--threads" "-1"
      "--ctx-size" "16384"
      "--temp" "1.0"
      "--top-p" "1.0"
      "--top-k" "0"
    ];
  };
}
