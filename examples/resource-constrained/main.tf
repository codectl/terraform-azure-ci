module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "container_instance" {
  source  = "cloudnationhq/ci/azure"
  version = "~> 2.0"

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
