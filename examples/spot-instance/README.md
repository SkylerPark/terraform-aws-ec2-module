# spot-instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_public_subnet_group"></a> [public\_subnet\_group](#module\_public\_subnet\_group) | git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/subnet-group/ | tags/1.1.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/security-group/ | tags/1.1.0 |
| <a name="module_spot_requist"></a> [spot\_requist](#module\_spot\_requist) | ../../modules/instance | n/a |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ../../modules/key-pair | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/vpc/ | tags/1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ami.amazon_linux2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
