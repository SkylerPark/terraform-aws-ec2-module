# key-pair

## 기능

key pair 생성

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.21 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.21 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_private_key"></a> [create\_private\_key](#input\_create\_private\_key) | (선택) private key 생성 여부. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) SSH key pair 이름. | `string` | n/a | yes |
| <a name="input_private_key_algorithm"></a> [private\_key\_algorithm](#input\_private\_key\_algorithm) | (선택) private key 생성시 알고리즘. 지원하는 값 `RSA` and `ED25519` default: `RSA` | `string` | `"RSA"` | no |
| <a name="input_private_key_rsa_bits"></a> [private\_key\_rsa\_bits](#input\_private\_key\_rsa\_bits) | (선택) 알고리즘이 `RSA` 일때, RSA key bits 사이즈 default: `4096` | `number` | `4096` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | (선택) 공개키 내용. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | key pair ID |
| <a name="output_name"></a> [name](#output\_name) | key pair name |
| <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem) | Private key data PEM (RFC 1421) |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | key pair public key |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
