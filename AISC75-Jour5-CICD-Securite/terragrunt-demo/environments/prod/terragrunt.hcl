include "root" { path = find_in_parent_folders() }

terraform {
  source = "../../modules/nginx/nginx-config"
}

inputs = {
  environment      = "prod"
  worker_processes = 1
  serveurs = [
    {
      nom         = "front-prod"
      port        = 80
      server_name = "prod.local"
      root_path   = "/var/www/prod"
    }
  ]
}
