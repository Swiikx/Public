# modules/nginx-config/variables.tf

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L environnement doit être dev, staging ou prod."
  }
}

variable "serveurs" {
  description = "Configuration des serveurs virtuels Nginx"
  type = list(object({
    nom           = string
    port          = number
    server_name   = string
    root_path     = string
    index         = optional(string, "index.html")
    ssl_enabled   = optional(bool, false)
    rate_limiting = optional(bool, false)
    locations = optional(list(object({
      path       = string
      proxy_pass = optional(string, "")
      static     = optional(bool, false)
    })), [])
  }))
}

variable "worker_processes" {
  description = "Nombre de worker processes Nginx"
  type        = number
  default     = 1
  validation {
    condition     = var.worker_processes >= 1 && var.worker_processes <= 32
    error_message = "worker_processes doit être entre 1 et 32."
  }
}

variable "output_dir" {
  description = "Répertoire de sortie pour les fichiers de config"
  type        = string
  default     = "./nginx-configs"
}
