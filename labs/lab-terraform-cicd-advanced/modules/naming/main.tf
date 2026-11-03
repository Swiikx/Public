terraform {
  required_version = ">= 1.5.0"
}

locals {
  naming_convention = {
    for app in var.applications :
    app.name => {
      logical_name = "${var.project_name}-${var.environment}-${app.name}"
      short_name   = "${var.environment}-${app.name}"
      tier_code    = substr(app.tier, 0, 3)
      owner_team   = app.team
      port         = app.port
    }
  }
}
