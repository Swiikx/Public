# Tests natifs Terraform pour le module nginx-config
# Lancer : terraform test (depuis modules/nginx-config/)

variables {
  environment      = "dev"
  worker_processes = 2
  output_dir       = "./test-output"
  serveurs = [
    {
      nom         = "test-frontend"
      port        = 8080
      server_name = "test.local"
      root_path   = "/var/www/test"
    }
  ]
}

run "validation_env_dev" {
  command = plan

  assert {
    condition     = local.log_level == "debug"
    error_message = "En dev, log_level doit être debug"
  }

  assert {
    condition     = local.effective_workers == 2
    error_message = "En dev, effective_workers doit valoir la variable (pas forcé à 4)"
  }
}

run "validation_env_prod_force_4_workers" {
  command = plan

  variables {
    environment      = "prod"
    worker_processes = 1
  }

  assert {
    condition     = local.effective_workers == 4
    error_message = "En prod, effective_workers doit être forcé à min 4"
  }

  assert {
    condition     = local.log_level == "warn"
    error_message = "En prod, log_level doit être warn"
  }

  assert {
    condition     = local.serveurs_enrichis[0].ssl_enabled == true
    error_message = "En prod, ssl_enabled doit être forcé à true"
  }
}

run "validation_environnement_invalide" {
  command = plan

  variables {
    environment = "qualif"
  }

  expect_failures = [
    var.environment,
  ]
}
