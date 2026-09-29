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

    container = {
      worker1 = {
        name   = "worker-1"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 0.25
        memory = 0.5

        environment_variables = {
          WORKER_ID = "1"
          QUEUE     = "low-priority"
        }
      }
      worker2 = {
        name   = "worker-2"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 0.25
        memory = 0.5

        environment_variables = {
          WORKER_ID = "2"
          QUEUE     = "low-priority"
        }
      }
      scheduler = {
        name   = "scheduler"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 0.5
        memory = 0.5

        ports = {
          http = {
            port     = 8080
            protocol = "TCP"
          }
        }

        environment_variables = {
          ROLE         = "scheduler"
          WORKER_COUNT = "2"
        }
      }
    }
  }
}
