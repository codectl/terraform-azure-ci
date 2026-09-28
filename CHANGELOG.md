# Changelog

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-ci/compare/v1.0.0...v2.0.0) (2026-09-21)


### ⚠ BREAKING CHANGES

* this change causes recreates

### Features

* azurerm provider 5 upgrade ([#9](https://github.com/CloudNationHQ/terraform-azure-ci/issues/9)) ([201c6af](https://github.com/CloudNationHQ/terraform-azure-ci/commit/201c6af63dc7ce386f5649ca14483a8349648e52))

## 1.0.0 (2025-10-17)


### Features

* add initial files ([#1](https://github.com/CloudNationHQ/terraform-azure-ci/issues/1)) ([7c8de55](https://github.com/CloudNationHQ/terraform-azure-ci/commit/7c8de55d8353d38e4f65c16c05ec1a9b7dfd059a))

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v2.0.0...v2.1.0) (2025-08-13)


### Features

* **deps:** bump github.com/cloudnationhq/az-cn-go-validor in /tests ([#49](https://github.com/CloudNationHQ/terraform-azure-pe/issues/49)) ([aaecc78](https://github.com/CloudNationHQ/terraform-azure-pe/commit/aaecc784b80676db73233eb39585ae22bedcb99b))


### Bug Fixes

* enhance variable validation and remove redundant null defaults ([#50](https://github.com/CloudNationHQ/terraform-azure-pe/issues/50)) ([6ce0f33](https://github.com/CloudNationHQ/terraform-azure-pe/commit/6ce0f333c4cb8b755354f342d32f047d578be2b3))
* enhance variable validation and remove redundant null defaults ([#52](https://github.com/CloudNationHQ/terraform-azure-pe/issues/52)) ([480acea](https://github.com/CloudNationHQ/terraform-azure-pe/commit/480acea024ad2063031e386fa800684bf47c0b39))
* revert enhance variable validation and remove redundant null defaults (…" ([#51](https://github.com/CloudNationHQ/terraform-azure-pe/issues/51)) ([e0569f3](https://github.com/CloudNationHQ/terraform-azure-pe/commit/e0569f35215a31361bc22695983b1ff3db53911b))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.4.4...v2.0.0) (2025-06-18)


### ⚠ BREAKING CHANGES

* The data structure changed, causing a recreate on existing resources.

### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#47](https://github.com/CloudNationHQ/terraform-azure-pe/issues/47)) ([a57a34a](https://github.com/CloudNationHQ/terraform-azure-pe/commit/a57a34a6097d601f4faa1edafb415c217b39509a))
* **deps:** bump golang.org/x/net from 0.33.0 to 0.36.0 in /tests ([#43](https://github.com/CloudNationHQ/terraform-azure-pe/issues/43)) ([346ab83](https://github.com/CloudNationHQ/terraform-azure-pe/commit/346ab83839f5cc649bbd49666fe6216fd2fb56c3))
* **deps:** bump golang.org/x/net from 0.36.0 to 0.38.0 in /tests ([#45](https://github.com/CloudNationHQ/terraform-azure-pe/issues/45)) ([8517b16](https://github.com/CloudNationHQ/terraform-azure-pe/commit/8517b1649a2d0351b3bc8d1effa1e2bd812aaa35))
* small refactor ([#48](https://github.com/CloudNationHQ/terraform-azure-pe/issues/48)) ([a4b49a3](https://github.com/CloudNationHQ/terraform-azure-pe/commit/a4b49a38ed2d6d9b895f3132eccf85f34321ed0a))

### Upgrade from v1.4.4 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`
- The property and variable resource_group is renamed to resource_group_name
- The structure changed for private_service_connection
- The structure changed for private_dns_zone_group

See the usage examples for details

## [1.4.4](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.4.3...v1.4.4) (2025-01-30)


### Bug Fixes

* make subresource names property optional ([#40](https://github.com/CloudNationHQ/terraform-azure-pe/issues/40)) ([dd63dac](https://github.com/CloudNationHQ/terraform-azure-pe/commit/dd63dacb688a3fbebe3b209d1ed81bc50e9e3833))

## [1.4.3](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.4.2...v1.4.3) (2025-01-28)


### Bug Fixes

* the private_connection_resource_id  is an optional value ([#37](https://github.com/CloudNationHQ/terraform-azure-pe/issues/37)) ([787ce12](https://github.com/CloudNationHQ/terraform-azure-pe/commit/787ce12bd7a526712ad0c0b57990ed5ae211d27f))

## [1.4.2](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.4.1...v1.4.2) (2025-01-21)


### Bug Fixes

* fix coalesce functions for reseourcegroup and location ([#35](https://github.com/CloudNationHQ/terraform-azure-pe/issues/35)) ([9055443](https://github.com/CloudNationHQ/terraform-azure-pe/commit/9055443cd0fb5d9aa02e271120f4ca91b6b8001d))

## [1.4.1](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.4.0...v1.4.1) (2025-01-20)


### Bug Fixes

* Make location optional on main level ([#33](https://github.com/CloudNationHQ/terraform-azure-pe/issues/33)) ([8e0e585](https://github.com/CloudNationHQ/terraform-azure-pe/commit/8e0e585ff79b887b75538c46b6dc7adb815e9ed5))

## [1.4.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.3.0...v1.4.0) (2025-01-20)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#29](https://github.com/CloudNationHQ/terraform-azure-pe/issues/29)) ([1ed3deb](https://github.com/CloudNationHQ/terraform-azure-pe/commit/1ed3deb5f84d28dcb8ca60a3fce16dd24ec7551b))
* **deps:** bump golang.org/x/crypto from 0.21.0 to 0.31.0 in /tests ([#27](https://github.com/CloudNationHQ/terraform-azure-pe/issues/27)) ([77f2868](https://github.com/CloudNationHQ/terraform-azure-pe/commit/77f28689ef5adf768b6381bc2140afd58d54102d))
* **deps:** bump golang.org/x/net from 0.23.0 to 0.33.0 in /tests ([#32](https://github.com/CloudNationHQ/terraform-azure-pe/issues/32)) ([0eb3977](https://github.com/CloudNationHQ/terraform-azure-pe/commit/0eb3977f5d3225b78384f1e14a11d1dc81104007))
* remove temporary files when deployment tests fails ([#30](https://github.com/CloudNationHQ/terraform-azure-pe/issues/30)) ([d36e1af](https://github.com/CloudNationHQ/terraform-azure-pe/commit/d36e1afd739b1ef1d5ea40751dd4ea08ec5aba1e))

## [1.3.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.2.0...v1.3.0) (2024-12-06)


### Features

* small refactor, added type definitions and incremented module versions ([#25](https://github.com/CloudNationHQ/terraform-azure-pe/issues/25)) ([ee2414f](https://github.com/CloudNationHQ/terraform-azure-pe/commit/ee2414f7e6a6923e1321e4846fd3595895ae94f1))

## [1.2.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.1.3...v1.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#23](https://github.com/CloudNationHQ/terraform-azure-pe/issues/23)) ([02c6ab2](https://github.com/CloudNationHQ/terraform-azure-pe/commit/02c6ab2c2eff8a1fe41c231516c9510f0719b6ed))

## [1.1.3](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.1.2...v1.1.3) (2024-10-30)


### Bug Fixes

* fix locals to include request message ([#21](https://github.com/CloudNationHQ/terraform-azure-pe/issues/21)) ([d1e252e](https://github.com/CloudNationHQ/terraform-azure-pe/commit/d1e252ef8ce0d2e52e97f43e4e9bb139c2ca6752))

## [1.1.2](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.1.1...v1.1.2) (2024-10-30)


### Bug Fixes

* add request message parameter to private service connection ([#19](https://github.com/CloudNationHQ/terraform-azure-pe/issues/19)) ([68165c2](https://github.com/CloudNationHQ/terraform-azure-pe/commit/68165c2096feac9e4b67a91ff04fb1fc49206d3f))

## [1.1.1](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.1.0...v1.1.1) (2024-10-30)


### Bug Fixes

* fixed manual connection property in private service connection ([#17](https://github.com/CloudNationHQ/terraform-azure-pe/issues/17)) ([41dc14e](https://github.com/CloudNationHQ/terraform-azure-pe/commit/41dc14eb63dbdad72a5448ad7c8086baff630341))

## [1.1.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v1.0.0...v1.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#15](https://github.com/CloudNationHQ/terraform-azure-pe/issues/15)) ([205c55d](https://github.com/CloudNationHQ/terraform-azure-pe/commit/205c55df62a6109c8c87fe371d06748b55f6cd0b))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#14](https://github.com/CloudNationHQ/terraform-azure-pe/issues/14)) ([ac1a563](https://github.com/CloudNationHQ/terraform-azure-pe/commit/ac1a56389c0011b56c1dcd5b8e401047bd7899bb))

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v0.4.0...v1.0.0) (2024-09-24)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#12](https://github.com/CloudNationHQ/terraform-azure-pe/issues/12)) ([a0b0dd8](https://github.com/CloudNationHQ/terraform-azure-pe/commit/a0b0dd85b50af9ca57d0c1de5864b70d29e1b1eb))

### Upgrade from v0.4.0 to v1.0.0:

- Update module reference to: `version = "~> 1.0"`
- Rename properties in endpoints object:
  - resourcegroup -> resource_group
- Rename variable:
  - resourcegroup -> resource_group

## [0.4.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v0.3.0...v0.4.0) (2024-08-28)


### Features

* update documentation ([#9](https://github.com/CloudNationHQ/terraform-azure-pe/issues/9)) ([0368b16](https://github.com/CloudNationHQ/terraform-azure-pe/commit/0368b16e47f6b499109231374c0aac27bfdcf085))

## [0.3.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v0.2.0...v0.3.0) (2024-07-02)


### Features

* add issue template ([#8](https://github.com/CloudNationHQ/terraform-azure-pe/issues/8)) ([31566c9](https://github.com/CloudNationHQ/terraform-azure-pe/commit/31566c9083662fe9f056ce7f36926cbc403dcd99))
* create pull request template ([#6](https://github.com/CloudNationHQ/terraform-azure-pe/issues/6)) ([acb6fe2](https://github.com/CloudNationHQ/terraform-azure-pe/commit/acb6fe220242bfb07d5e96069096a60431a445f2))

## [0.2.0](https://github.com/CloudNationHQ/terraform-azure-pe/compare/v0.1.0...v0.2.0) (2024-03-15)


### Features

* update documentation ([#4](https://github.com/CloudNationHQ/terraform-azure-pe/issues/4)) ([d2ece61](https://github.com/CloudNationHQ/terraform-azure-pe/commit/d2ece61eefba1b328b51787d3e6e365db0945847))

## 0.1.0 (2024-03-14)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-pe/issues/2)) ([3b2e082](https://github.com/CloudNationHQ/terraform-azure-pe/commit/3b2e0823bf64b0a32df98e84775b0c14864c7d86))
