project_name = "campus-platform"
environment  = "dev"
region       = "europe-west1"
owner        = "student-devops"

applications = [
  {
    name            = "portal"
    tier            = "frontend"
    port            = 8080
    criticality     = "medium"
    exposure        = "public"
    team            = "web"
    estimated_users = 300
  },
  {
    name            = "notes"
    tier            = "backend"
    port            = 8081
    criticality     = "high"
    exposure        = "private"
    team            = "data"
    estimated_users = 250
  },
  {
    name            = "presence"
    tier            = "backend"
    port            = 8082
    criticality     = "medium"
    exposure        = "private"
    team            = "ops"
    estimated_users = 200
  },
  {
    name            = "planning"
    tier            = "internal"
    port            = 8083
    criticality     = "low"
    exposure        = "private"
    team            = "admin"
    estimated_users = 100
  }
]
