# Exercice Terraform — bases
# Exemple neutre avec le provider "local" : création de fichiers

terraform {
  required_version = ">= 1.5"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

variable "message" {
  type        = string
  description = "Message à écrire dans le fichier"
  default     = "Hello Terraform"
}

variable "filename" {
  type    = string
  default = "output.txt"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "local_file" "hello" {
  filename = "${path.module}/${random_id.suffix.hex}-${var.filename}"
  content  = var.message
}

output "file_path" {
  value       = local_file.hello.filename
  description = "Chemin du fichier généré"
}
