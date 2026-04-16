terraform {
  required_version = ">= 1.5.0"
}

locals {
  prod_frontend_port_ok = alltrue([
    for app in var.applications :
    var.environment != "prod" || app.tier != "frontend" || contains([80, 443], app.port)
  ])

  no_public_internal_in_prod = alltrue([
    for app in var.applications :
    var.environment != "prod" || !(app.tier == "internal" && app.exposure == "public")
  ])

  teams_defined = alltrue([
    for app in var.applications :
    length(trim(app.team, " ")) > 0
  ])

  compliance_summary = {
    environment                = var.environment
    prod_frontend_port_ok      = local.prod_frontend_port_ok
    no_public_internal_in_prod = local.no_public_internal_in_prod
    teams_defined              = local.teams_defined
    compliant                  = local.prod_frontend_port_ok && local.no_public_internal_in_prod && local.teams_defined
  }
}
