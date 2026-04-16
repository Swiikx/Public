include "root" { path = find_in_parent_folders() }

terraform {
  source = "../../modules/nginx/nginx-config"
}

inputs = {
  environment      = "dev"
  worker_processes = 2
  serveurs = [
    {
      nom         = "front-dev"
      port        = 80
      server_name = "dev.local"
      root_path   = "/var/www/dev"
    }
  ]
}
