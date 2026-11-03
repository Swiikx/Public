plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Décommenter si le projet déclare des locals ou variables volontairement non consommés.
# rule "terraform_unused_declarations" {
#   enabled = false
# }
