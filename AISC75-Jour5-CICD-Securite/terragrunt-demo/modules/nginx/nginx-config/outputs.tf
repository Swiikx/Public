output "config_files" {
  description = "Liste des fichiers de configuration générés"
  value = concat(
    [local_file.nginx_conf.filename],
    [for f in local_file.vhost_configs : f.filename],
    [local_file.deployment_summary.filename]
  )
}

output "serveurs_configures" {
  description = "Résumé des serveurs configurés"
  value = {
    for s in local.serveurs_enrichis : s.nom => {
      server_name = s.server_name
      port        = s.port
      ssl         = s.ssl_enabled
    }
  }
}
