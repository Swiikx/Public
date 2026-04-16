# modules/nginx-config/main.tf

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

locals {
  # Worker processes auto selon l'environnement
  effective_workers = var.environment == "prod" ? max(var.worker_processes, 4) : var.worker_processes

  # Logs selon l'environnement
  log_level = var.environment == "prod" ? "warn" : "debug"

  # Serveurs avec SSL en prod
  serveurs_enrichis = [for s in var.serveurs : merge(s, {
    ssl_enabled   = var.environment == "prod" ? true : s.ssl_enabled
    rate_limiting = var.environment == "prod" ? true : s.rate_limiting
  })]
}

# Fichier de configuration Nginx principal
resource "local_file" "nginx_conf" {
  filename        = "${var.output_dir}/nginx.conf"
  file_permission = "0644"

  content = <<-EOT
# nginx.conf - Généré par Terraform
# Environnement : ${upper(var.environment)}
# NE PAS MODIFIER MANUELLEMENT

worker_processes ${local.effective_workers};
error_log /var/log/nginx/error.log ${local.log_level};
pid /var/run/nginx.pid;

events {
    worker_connections ${var.environment == "prod" ? 1024 : 256};
    multi_accept on;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent"';

    access_log /var/log/nginx/access.log main;
    sendfile on;

    ${var.environment == "prod" ? "gzip on;\n    gzip_min_length 1000;\n    gzip_types text/plain application/json;" : "# gzip désactivé en dev"}

    keepalive_timeout 65;

    # Inclure les virtual hosts
    include /etc/nginx/conf.d/*.conf;
}
EOT
}

# Fichier de configuration par serveur virtuel
resource "local_file" "vhost_configs" {
  count           = length(local.serveurs_enrichis)
  filename        = "${var.output_dir}/conf.d/${local.serveurs_enrichis[count.index].nom}.conf"
  file_permission = "0644"

  content = templatefile("${path.module}/vhost.tpl", {
    serveur     = local.serveurs_enrichis[count.index]
    environment = var.environment
  })
}

# Fichier de résumé de déploiement
resource "local_file" "deployment_summary" {
  filename = "${var.output_dir}/DEPLOYMENT.md"

  content = <<-EOT
# Déploiement Nginx — ${upper(var.environment)}

| Paramètre | Valeur |
|-----------|--------|
| Environnement | ${var.environment} |
| Worker Processes | ${local.effective_workers} |
| Log Level | ${local.log_level} |
| Nombre de vhosts | ${length(var.serveurs)} |

## Virtual Hosts configurés

${join("\n", [for s in var.serveurs : "- **${s.nom}** → ${s.server_name}:${s.port}"])}

*Généré par Terraform le ${timestamp()}*
EOT
}
