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

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 5.0"


  storage = {
    name                = module.naming.storage_account.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    share_properties = {
      shares = {
        config = {
          quota = 5
        }
        data = {
          quota = 10
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

    container = {
      app = {
        name   = "app-with-volumes"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 1
        memory = 1

        ports = {
          http = {
            port     = 80
            protocol = "TCP"
          }
        }

        volume = {
          config = {
            name       = "config-volume"
            mount_path = "/etc/config"
            read_only  = true

            storage_account_name = module.storage.account.name
            storage_account_key  = module.storage.account.primary_access_key
            share_name           = module.storage.shares.config.name
          }
          data = {
            name       = "data-volume"
            mount_path = "/app/data"
            read_only  = false

            storage_account_name = module.storage.account.name
            storage_account_key  = module.storage.account.primary_access_key
            share_name           = module.storage.shares.data.name
          }
          tmp = {
            name       = "tmp-volume"
            mount_path = "/tmp"
            empty_dir  = true
          }
        }
      }
    }
  }
}
