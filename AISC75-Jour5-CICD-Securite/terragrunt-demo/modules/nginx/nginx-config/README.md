# Module nginx-config

Module Terraform qui génère des fichiers de configuration Nginx pour différents environnements.

## Variables

| Nom | Type | Description | Défaut |
|-----|------|-------------|--------|
| environment | string | Environnement (dev, staging, prod) | - |
| serveurs | list(object) | Liste des serveurs virtuels | - |
| worker_processes | number | Nombre de workers Nginx | 1 |
| output_dir | string | Répertoire de sortie | ./nginx-configs |

## Outputs

| Nom | Description |
|-----|-------------|
| config_files | Liste des fichiers générés |
| serveurs_configures | Résumé des serveurs avec SSL/port |
