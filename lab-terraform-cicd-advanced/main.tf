terraform {
  required_version = ">= 1.5.0"
}

locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    region      = var.region
    managed_by  = "terraform"
  }

  app_map = {
    for app in var.applications :
    app.name => app
  }

  apps_by_tier = {
    frontend = [for app in var.applications : app.name if app.tier == "frontend"]
    backend  = [for app in var.applications : app.name if app.tier == "backend"]
    internal = [for app in var.applications : app.name if app.tier == "internal"]
  }

  public_apps   = [for app in var.applications : app.name if app.exposure == "public"]
  private_apps  = [for app in var.applications : app.name if app.exposure == "private"]
  critical_apps = [for app in var.applications : app.name if app.criticality == "high"]

  estimated_capacity_units = sum([
    for app in var.applications :
    app.criticality == "high" ? app.estimated_users * 3 :
    app.criticality == "medium" ? app.estimated_users * 2 :
    app.estimated_users
  ])

  estimated_monthly_cost = sum([
    for app in var.applications :
    app.criticality == "high" ? 120 :
    app.criticality == "medium" ? 70 :
    30
  ])

  platform_matrix = [
    for app in var.applications : {
      logical_name    = "${var.project_name}-${var.environment}-${app.name}"
      fqdn            = app.exposure == "public" ? "${app.name}.${var.environment}.example.local" : null
      tier            = upper(app.tier)
      port            = app.port
      exposure        = upper(app.exposure)
      criticality     = upper(app.criticality)
      team            = upper(app.team)
      estimated_users = app.estimated_users
    }
  ]
}

module "naming" {
  source       = "./modules/naming"
  project_name = var.project_name
  environment  = var.environment
  applications = var.applications
}

module "compliance" {
  source       = "./modules/compliance"
  environment  = var.environment
  applications = var.applications
}
