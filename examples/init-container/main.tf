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

    init_container = {
      setup = {
        name  = "init-setup"
        image = "mcr.microsoft.com/azure-cli:latest"

        commands = [
          "/bin/sh",
          "-c",
          "echo 'Initializing application...' && sleep 5 && echo 'Setup complete'"
        ]

        environment_variables = {
          INIT_PHASE = "setup"
        }
      }
    }

    container = {
      app = {
        name   = "main-app"
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
          APP_MODE = "production"
        }
      }
    }
  }
}
