variable "container_group" {
  description = "Contains all container instance configuration"
  type = object({
    name                                = string
    resource_group_name                 = optional(string)
    location                            = optional(string)
    ip_address_type                     = optional(string)
    dns_name_label                      = optional(string)
    restart_policy                      = optional(string)
    os_type                             = optional(string, "Linux")
    sku                                 = optional(string)
    key_vault_key_id                    = optional(string)
    dns_name_label_reuse_policy         = optional(string)
    key_vault_user_assigned_identity_id = optional(string)
    subnet_ids                          = optional(list(string))
    priority                            = optional(string)
    zones                               = optional(list(string))
    tags                                = optional(map(string))
    exposed_port = optional(map(object({
      port     = number
      protocol = optional(string)
    })), {})
    image_registry_credential = optional(map(object({
      username                  = optional(string)
      password                  = optional(string)
      server                    = optional(string, "index.docker.io")
      user_assigned_identity_id = optional(string)
    })), {})
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    dns_config = optional(object({
      nameservers    = list(string)
      search_domains = optional(list(string))
      options        = optional(list(string))
    }))
    diagnostics = optional(object({
      log_analytics = object({
        workspace_id  = string
        workspace_key = string
        log_type      = optional(string)
        metadata      = optional(map(string))
      })
    }))
    init_container = optional(map(object({
      name                         = string
      image                        = string
      environment_variables        = optional(map(string), {})
      secure_environment_variables = optional(map(string), {})
      commands                     = optional(list(string))
      security = optional(map(object({
        privilege_enabled = bool
      })), {})
      volume = optional(map(object({
        name                 = string
        mount_path           = string
        empty_dir            = optional(bool)
        read_only            = optional(bool)
        share_name           = optional(string)
        storage_account_name = optional(string)
        storage_account_key  = optional(string)
        secret               = optional(map(string))
        git_repo = optional(object({
          url       = string
          directory = optional(string)
          revision  = optional(string)
        }))
      })), {})
    })), {})
    container = map(object({
      name                         = string
      image                        = string
      cpu                          = number
      memory                       = number
      cpu_limit                    = optional(number)
      memory_limit                 = optional(number)
      commands                     = optional(list(string))
      environment_variables        = optional(map(string), {})
      secure_environment_variables = optional(map(string), {})
      ports = optional(map(object({
        port     = number
        protocol = optional(string)
      })), {})
      security = optional(map(object({
        privilege_enabled = bool
      })), {})
      volume = optional(map(object({
        name                 = string
        mount_path           = string
        empty_dir            = optional(bool)
        read_only            = optional(bool)
        share_name           = optional(string)
        storage_account_name = optional(string)
        storage_account_key  = optional(string)
        secret               = optional(map(string))
        git_repo = optional(object({
          url       = string
          directory = optional(string)
          revision  = optional(string)
        }))
      })), {})
      liveness_probe = optional(object({
        initial_delay_seconds = optional(number, 0)
        period_seconds        = optional(number, 10)
        failure_threshold     = optional(number, 3)
        success_threshold     = optional(number, 1)
        timeout_seconds       = optional(number, 1)
        exec                  = optional(list(string))
        http_get = optional(object({
          path         = optional(string, "/")
          port         = number
          scheme       = optional(string, "http")
          http_headers = optional(map(string))
        }))
      }))
      readiness_probe = optional(object({
        initial_delay_seconds = optional(number, 0)
        success_threshold     = optional(number, 1)
        period_seconds        = optional(number, 10)
        timeout_seconds       = optional(number, 1)
        failure_threshold     = optional(number, 3)
        exec                  = optional(list(string))
        http_get = optional(object({
          path         = optional(string, "/")
          port         = number
          scheme       = optional(string, "http")
          http_headers = optional(map(string))
        }))
      }))
    }))
  })

  validation {
    condition     = var.container_group.location != null || var.location != null
    error_message = "Location must be provided either in the container_group object or as a separate variable."
  }

  validation {
    condition     = var.container_group.resource_group_name != null || var.resource_group_name != null
    error_message = "Resource group name must be provided either in the container_group object or as a separate variable."
  }
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
