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
      app = {
        name   = "app-with-exec-probes"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
        cpu    = 1
        memory = 1

        ports = {
          http = {
            port     = 80
            protocol = "TCP"
          }
        }

        liveness_probe = {
          initial_delay_seconds = 30
          period_seconds        = 10
          failure_threshold     = 3
          timeout_seconds       = 5

          exec = [
            "/bin/sh",
            "-c",
            "test -f /tmp/healthy"
          ]
        }

        readiness_probe = {
          initial_delay_seconds = 10
          period_seconds        = 5
          failure_threshold     = 3
          timeout_seconds       = 3

          exec = [
            "/bin/sh",
            "-c",
            "test -f /tmp/ready && exit 0 || exit 1"
          ]
        }
      }
    }
  }
}
