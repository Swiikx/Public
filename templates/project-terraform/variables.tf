variable "project_name" {
  description = "Nom du projet, utilisé comme préfixe de nommage des ressources."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,30}$", var.project_name))
    error_message = "project_name doit être en minuscules, commencer par une lettre, et ne contenir que des lettres, chiffres et tirets (2 à 31 caractères)."
  }
}

variable "environment" {
  description = "Environnement cible."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment doit valoir dev, staging ou prod."
  }
}

variable "tags" {
  description = "Tags additionnels fusionnés avec les tags communs."
  type        = map(string)
  default     = {}
}
