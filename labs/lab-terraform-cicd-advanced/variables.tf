variable "project_name" {
  description = "Nom du projet"
  type        = string
  validation {
    condition     = length(var.project_name) >= 3
    error_message = "Le nom du projet doit contenir au moins 3 caractères."
  }
}

variable "environment" {
  description = "Environnement cible"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment doit être dev, staging ou prod."
  }
}

variable "region" {
  description = "Région logique"
  type        = string
}

variable "owner" {
  description = "Responsable du projet"
  type        = string
}

variable "applications" {
  description = "Liste des applications"
  type = list(object({
    name            = string
    tier            = string
    port            = number
    criticality     = string
    exposure        = string
    team            = string
    estimated_users = number
  }))

  validation {
    condition = alltrue([
      for app in var.applications :
      contains(["frontend", "backend", "internal"], app.tier)
    ])
    error_message = "tier doit être frontend, backend ou internal."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      contains(["public", "private"], app.exposure)
    ])
    error_message = "exposure doit être public ou private."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      contains(["low", "medium", "high"], app.criticality)
    ])
    error_message = "criticality doit être low, medium ou high."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      app.port > 0 && app.port < 9000
    ])
    error_message = "Les ports doivent être compris entre 1 et 8999."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      app.estimated_users >= 0
    ])
    error_message = "estimated_users doit être positif."
  }

  validation {
    condition     = length(toset([for app in var.applications : app.name])) == length(var.applications)
    error_message = "Les noms d'application doivent être uniques."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      var.environment != "prod" || !(app.tier == "internal" && app.exposure == "public")
    ])
    error_message = "En prod, une application internal ne peut pas être publique."
  }

  validation {
    condition = alltrue([
      for app in var.applications :
      var.environment != "prod" || app.tier != "frontend" || contains([80, 443], app.port)
    ])
    error_message = "En prod, les frontend doivent utiliser 80 ou 443."
  }
}
