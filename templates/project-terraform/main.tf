locals {
  # Préfixe de nommage commun à toutes les ressources.
  name_prefix = "${var.project_name}-${var.environment}"

  # Tags appliqués partout, fusionnés avec les tags passés en variable.
  common_tags = merge(
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "terraform"
    },
    var.tags
  )
}

# Les ressources vont ici.
#
# resource "<type>" "<nom>" {
#   name = "${local.name_prefix}-<suffixe>"
#   tags = local.common_tags
# }
