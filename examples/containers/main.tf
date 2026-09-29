module "naming" {
  source  = "codectl/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "regions" {
  source  = "codectl/locations/azure"
  version = "~> 1.0"

  location = {
    primary = "westeurope"
  }
}

module "rg" {
  source  = "codectl/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = module.regions.location.primary.name
    }
  }
}

module "container_instance" {
  source  = "codectl/ci/azure"
  version = "~> 1.0"

  container_group = {
    name                = module.naming.container_group.name
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    dns_name_label      = module.naming.container_group.name_unique

    exposed_port = {
      http = {
        port     = 80
        protocol = "TCP"
      }
      api = {
        port     = 8080
        protocol = "TCP"
      }
    }

    container = {
      frontend = {
        name   = "frontend"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 1
        memory = 1

        ports = {
          http = {
            port     = 80
            protocol = "TCP"
          }
        }

        environment_variables = {
          BACKEND_URL = "http://localhost:8080"
          APP_NAME    = "frontend"
        }
      }

      backend = {
        name   = "backend"
        image  = "mcr.microsoft.com/dotnet/samples:aspnetapp"
        cpu    = 1
        memory = 1

        ports = {
          http = {
            port     = 8080
            protocol = "TCP"
          }
        }

        environment_variables = {
          ASPNETCORE_URLS = "http://+:8080"
          APP_NAME        = "backend"
        }
      }

      sidecar = {
        name   = "logging-sidecar"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 0.5
        memory = 0.5

        environment_variables = {
          ROLE     = "sidecar"
          LOG_PATH = "/var/log/app"
        }
      }
    }
  }
}
