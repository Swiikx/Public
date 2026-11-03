project_name = "campus-platform"
environment  = "staging"
region       = "europe-west1"
owner        = "student-devops"

applications = [
  {
    name            = "portal"
    tier            = "frontend"
    port            = 8080
    criticality     = "high"
    exposure        = "public"
    team            = "web"
    estimated_users = 500
  },
  {
    name            = "notes"
    tier            = "backend"
    port            = 8081
    criticality     = "high"
    exposure        = "private"
    team            = "data"
    estimated_users = 350
  },
  {
    name            = "presence"
    tier            = "backend"
    port            = 8082
    criticality     = "medium"
    exposure        = "private"
    team            = "ops"
    estimated_users = 300
  },
  {
    name            = "reporting"
    tier            = "internal"
    port            = 8084
    criticality     = "medium"
    exposure        = "private"
    team            = "bi"
    estimated_users = 180
  }
]
