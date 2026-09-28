# Azure Container Instances

This terraform module provisions azure container Instances with flexible configuration for single or multi-container groups, including networking, probes, and registry options.

## Features

Utilization of terratest for robust validation

Multi-container deployments with sidecar patterns

Private networking with VNet integration

Persistent storage via Azure Files

Health monitoring with exec and HTTP probes

Init containers for setup tasks

Secret management with Key Vault integration

Resource optimization with fractional CPU/memory allocation

Batch job execution with custom restart policies

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 5.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 5.0)

## Resources

The following resources are used by this module:

- [azurerm_container_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_container_group"></a> [container\_group](#input\_container\_group)

Description: Contains all container instance configuration

Type:

```hcl
object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_container_group"></a> [container\_group](#output\_container\_group)

Description: Contains all container group configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md).

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/azure/container-instances/)
- [Rest Api](https://learn.microsoft.com/rest/api/container-instances/container-groups)
