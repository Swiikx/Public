# Exemples volontairement vulnérables pour démo checkov/tfsec
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

# Vulnérabilité : bucket S3 sans chiffrement ni blocage public
resource "aws_s3_bucket" "logs" {
  bucket = "mon-bucket-logs-demo"
}

# Vulnérabilité : SG ouvert SSH au monde entier
resource "aws_security_group" "bastion" {
  name = "bastion"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDP ouvert sur Internet, typiquement ce qui se fait tagger en audit
resource "aws_security_group" "windows_public" {
  name = "win-public"
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# trigger ci
