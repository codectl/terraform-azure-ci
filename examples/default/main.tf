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
    dns_name_label      = module.naming.container_group.name_unique

    container = {
      app = {
        name   = "app"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 1
        memory = 1.5

        ports = {
          http = {
            port     = 80
            protocol = "TCP"
          }
        }
      }
    }
  }
}
