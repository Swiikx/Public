# Racine : on simule un backend local (pas de S3 ici)
remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }
}

# Variables communes à tous les env
inputs = {
  output_dir = "./output"
}
