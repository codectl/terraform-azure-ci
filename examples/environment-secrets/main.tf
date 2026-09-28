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

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 6.0"


  vault = {
    name                = module.naming.key_vault.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    secrets = {
      random_string = {
        api_key = {
          length      = 32
          special     = true
          min_lower   = 5
          min_upper   = 5
          min_special = 5
          min_numeric = 5
        }
        db_password = {
          length      = 24
          special     = true
          min_lower   = 5
          min_upper   = 5
          min_special = 3
          min_numeric = 5
        }
        jwt_secret = {
          length      = 48
          special     = true
          min_lower   = 10
          min_upper   = 10
          min_special = 5
          min_numeric = 10
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
      secure_app = {
        name   = "secure-app"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 1
        memory = 1

        ports = {
          https = {
            port     = 443
            protocol = "TCP"
          }
        }

        environment_variables = {
          ENVIRONMENT = "production"
          LOG_LEVEL   = "info"
        }

        secure_environment_variables = {
          API_KEY     = module.kv.secrets.api_key.value
          DB_PASSWORD = module.kv.secrets.db_password.value
          JWT_SECRET  = module.kv.secrets.jwt_secret.value
        }
      }
    }
  }
}
