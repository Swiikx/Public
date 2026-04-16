output "common_tags" {
  value = local.common_tags
}

output "application_matrix" {
  value = local.platform_matrix
}

output "applications_by_tier" {
  value = local.apps_by_tier
}

output "public_apps" {
  value = local.public_apps
}

output "private_apps" {
  value = local.private_apps
}

output "critical_apps" {
  value = local.critical_apps
}

output "naming_convention" {
  value = module.naming.naming_convention
}

output "compliance_summary" {
  value = module.compliance.compliance_summary
}

output "estimated_capacity_units" {
  value = local.estimated_capacity_units
}

output "estimated_monthly_cost" {
  value = local.estimated_monthly_cost
}

output "deployment_summary" {
  value = {
    project                = var.project_name
    environment            = var.environment
    application_count      = length(var.applications)
    public_count           = length(local.public_apps)
    private_count          = length(local.private_apps)
    high_critical_count    = length(local.critical_apps)
    estimated_capacity     = local.estimated_capacity_units
    estimated_monthly_cost = local.estimated_monthly_cost
  }
}
