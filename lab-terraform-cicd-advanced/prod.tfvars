project_name = "campus-platform"
environment  = "prod"
region       = "europe-west1"
owner        = "student-devops"

applications = [
  {
    name            = "portal"
    tier            = "frontend"
    port            = 443
    criticality     = "high"
    exposure        = "public"
    team            = "web"
    estimated_users = 2000
  },
  {
    name            = "notes"
    tier            = "backend"
    port            = 8081
    criticality     = "high"
    exposure        = "private"
    team            = "data"
    estimated_users = 1200
  },
  {
    name            = "presence"
    tier            = "backend"
    port            = 8082
    criticality     = "high"
    exposure        = "private"
    team            = "ops"
    estimated_users = 1000
  },
  {
    name            = "reporting"
    tier            = "internal"
    port            = 8084
    criticality     = "medium"
    exposure        = "private"
    team            = "bi"
    estimated_users = 500
  }
]
