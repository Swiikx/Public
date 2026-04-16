# environments/dev/main.tf

terraform {
  required_version = ">= 1.5.0"
}

module "nginx_dev" {
  source = "../../modules/nginx-config"

  environment      = "dev"
  worker_processes = 2
  output_dir       = "${path.module}/../../output/dev/nginx"

  serveurs = [
    {
      nom         = "frontend"
      port        = 80
      server_name = "dev.monapp.local"
      root_path   = "/var/www/frontend"
      locations = [
        { path = "/api", proxy_pass = "http://localhost:3000" }
      ]
    },
    {
      nom         = "backend"
      port        = 3000
      server_name = "api.dev.monapp.local"
      root_path   = "/var/www/backend"
    },
    {
      nom         = "api-v2"
      port        = 8080
      server_name = "api-v2.dev.monapp.local"
      root_path   = "/var/www/api-v2"
      locations = [
        { path = "/health", static = true },
        { path = "/v2", proxy_pass = "http://localhost:4000" },
      ]
    }
  ]
}

output "fichiers_generes" {
  value = module.nginx_dev
}
