# container instances
resource "azurerm_container_group" "this" {
  resource_group_name = coalesce(
    var.container_group.resource_group_name,
    var.resource_group_name
  )

  location = coalesce(
    var.container_group.location,
    var.location
  )

  name                                = var.container_group.name
  ip_address_type                     = var.container_group.ip_address_type
  dns_name_label                      = var.container_group.dns_name_label
  restart_policy                      = var.container_group.restart_policy
  os_type                             = var.container_group.os_type
  sku                                 = var.container_group.sku
  key_vault_key_id                    = var.container_group.key_vault_key_id
  dns_name_label_reuse_policy         = var.container_group.dns_name_label_reuse_policy
  key_vault_user_assigned_identity_id = var.container_group.key_vault_user_assigned_identity_id
  subnet_ids                          = var.container_group.subnet_ids
  priority                            = var.container_group.priority
  zones                               = var.container_group.zones

  tags = coalesce(
    var.container_group.tags, var.tags
  )

  dynamic "exposed_port" {
    for_each = var.container_group.exposed_port

    content {
      port     = exposed_port.value.port
      protocol = exposed_port.value.protocol
    }
  }

  dynamic "image_registry_credential" {
    for_each = var.container_group.image_registry_credential

    content {
      username                  = image_registry_credential.value.username
      password                  = image_registry_credential.value.password
      server                    = image_registry_credential.value.server
      user_assigned_identity_id = image_registry_credential.value.user_assigned_identity_id
    }
  }

  dynamic "identity" {
    for_each = var.container_group.identity != null ? { "this" = var.container_group.identity } : {}

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "dns_config" {
    for_each = var.container_group.dns_config != null ? { "this" = var.container_group.dns_config } : {}

    content {
      nameservers    = dns_config.value.nameservers
      search_domains = dns_config.value.search_domains
      options        = dns_config.value.options
    }
  }

  dynamic "diagnostics" {
    for_each = var.container_group.diagnostics != null ? { "this" = var.container_group.diagnostics } : {}

    content {
      log_analytics {
        workspace_id  = diagnostics.value.log_analytics.workspace_id
        workspace_key = diagnostics.value.log_analytics.workspace_key
        log_type      = diagnostics.value.log_analytics.log_type
        metadata      = diagnostics.value.log_analytics.metadata
      }
    }
  }

  dynamic "init_container" {
    for_each = var.container_group.init_container

    content {
      name                         = init_container.value.name
      image                        = init_container.value.image
      environment_variables        = init_container.value.environment_variables
      secure_environment_variables = init_container.value.secure_environment_variables
      commands                     = init_container.value.commands

      dynamic "security" {
        for_each = init_container.value.security

        content {
          privilege_enabled = security.value.privilege_enabled
        }
      }

      dynamic "volume" {
        for_each = init_container.value.volume

        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          empty_dir            = volume.value.empty_dir
          read_only            = volume.value.read_only
          share_name           = volume.value.share_name
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          secret               = volume.value.secret

          dynamic "git_repo" {
            for_each = volume.value.git_repo != null ? { "this" = volume.value.git_repo } : {}

            content {
              url       = git_repo.value.url
              directory = git_repo.value.directory
              revision  = git_repo.value.revision
            }
          }
        }
      }
    }
  }

  dynamic "container" {
    for_each = var.container_group.container

    content {
      name                         = container.value.name
      image                        = container.value.image
      cpu                          = container.value.cpu
      memory                       = container.value.memory
      cpu_limit                    = container.value.cpu_limit
      memory_limit                 = container.value.memory_limit
      commands                     = container.value.commands
      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables

      dynamic "ports" {
        for_each = container.value.ports

        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }

      dynamic "security" {
        for_each = container.value.security

        content {
          privilege_enabled = security.value.privilege_enabled
        }
      }

      dynamic "volume" {
        for_each = container.value.volume

        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          empty_dir            = volume.value.empty_dir
          read_only            = volume.value.read_only
          share_name           = volume.value.share_name
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          secret               = volume.value.secret

          dynamic "git_repo" {
            for_each = volume.value.git_repo != null ? { "this" = volume.value.git_repo } : {}

            content {
              url       = git_repo.value.url
              directory = git_repo.value.directory
              revision  = git_repo.value.revision
            }
          }
        }
      }

      dynamic "liveness_probe" {
        for_each = container.value.liveness_probe != null ? { "this" = container.value.liveness_probe } : {}

        content {
          initial_delay_seconds = liveness_probe.value.initial_delay_seconds
          period_seconds        = liveness_probe.value.period_seconds
          failure_threshold     = liveness_probe.value.failure_threshold
          success_threshold     = liveness_probe.value.success_threshold
          timeout_seconds       = liveness_probe.value.timeout_seconds
          exec                  = liveness_probe.value.exec

          dynamic "http_get" {
            for_each = liveness_probe.value.http_get != null ? { "this" = liveness_probe.value.http_get } : {}

            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
        }
      }

      dynamic "readiness_probe" {
        for_each = container.value.readiness_probe != null ? { "this" = container.value.readiness_probe } : {}

        content {
          initial_delay_seconds = readiness_probe.value.initial_delay_seconds
          success_threshold     = readiness_probe.value.success_threshold
          period_seconds        = readiness_probe.value.period_seconds
          timeout_seconds       = readiness_probe.value.timeout_seconds
          failure_threshold     = readiness_probe.value.failure_threshold
          exec                  = readiness_probe.value.exec

          dynamic "http_get" {
            for_each = readiness_probe.value.http_get != null ? { "this" = readiness_probe.value.http_get } : {}

            content {
              path         = http_get.value.path
              port         = http_get.value.port
              scheme       = http_get.value.scheme
              http_headers = http_get.value.http_headers
            }
          }
        }
      }
    }
  }
}
