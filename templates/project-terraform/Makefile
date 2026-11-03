TFVARS ?= terraform.tfvars

.PHONY: help fmt init validate lint plan apply destroy clean

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

fmt: ## Formate le HCL récursivement
	terraform fmt -recursive

init: ## Initialise le working directory
	terraform init

validate: init ## Vérifie la syntaxe et les types
	terraform validate

lint: ## Lance TFLint récursivement
	tflint --recursive

plan: ## Calcule le plan avec $(TFVARS)
	terraform plan -var-file=$(TFVARS) -out=tfplan

apply: ## Applique le plan calculé
	terraform apply tfplan

destroy: ## Détruit l'infrastructure
	terraform destroy -var-file=$(TFVARS)

clean: ## Supprime les artefacts locaux
	rm -rf .terraform tfplan *.tfplan *-plan.json
