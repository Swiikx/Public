# environments/prod/main.tf

terraform {
  required_version = ">= 1.5.0"
}

module "nginx_prod" {
  source = "../../modules/nginx-config"

  environment      = "prod"
  worker_processes = 4
  output_dir       = "${path.module}/../../output/prod/nginx"

  serveurs = [
    {
      nom         = "frontend"
      port        = 443
      server_name = "www.monapp.com"
      root_path   = "/var/www/frontend"
      ssl_enabled = true
      locations = [
        { path = "/api", proxy_pass = "http://10.0.1.10:3000" },
        { path = "/static", static = true }
      ]
    },
    {
      nom         = "backend"
      port        = 3000
      server_name = "api.monapp.com"
      root_path   = "/var/www/backend"
      ssl_enabled = true
    },
    {
      nom         = "monitoring"
      port        = 9090
      server_name = "monitoring.monapp.com"
      root_path   = "/var/www/monitoring"
    }
  ]
}

output "fichiers_generes" {
  value = module.nginx_prod
}
