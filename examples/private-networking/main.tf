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

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 10.0"

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.0.0.0/16"]

    subnets = {
      containers = {
        address_prefixes = ["10.0.1.0/24"]
        delegations = {
          aci = {
            name = "Microsoft.ContainerInstance/containerGroups"
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/action"
            ]
          }
        }
      }
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
    ip_address_type     = "Private"

    subnet_ids = [module.network.subnets.containers.id]

    container = {
      internal = {
        name   = "internal-app"
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
          ENVIRONMENT = "private"
        }
      }
    }
  }
}
