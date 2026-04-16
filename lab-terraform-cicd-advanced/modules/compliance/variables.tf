variable "environment" {
  type = string
}

variable "applications" {
  type = list(object({
    name            = string
    tier            = string
    port            = number
    criticality     = string
    exposure        = string
    team            = string
    estimated_users = number
  }))
}
