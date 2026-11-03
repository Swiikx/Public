output "name_prefix" {
  description = "Préfixe de nommage calculé pour cet environnement."
  value       = local.name_prefix
}

output "common_tags" {
  description = "Tags appliqués aux ressources."
  value       = local.common_tags
}
