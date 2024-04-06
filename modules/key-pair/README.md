# key-pair

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | (필수) SSH key pair 이름. | `string` | n/a | yes |
| create_private_key | (선택) private key 생성 여부. | `bool` | `false` | no |
| private_key_algorithm | (선택) private key 생성시 알고리즘. 지원하는 값 `RSA` and `ED25519` default: `RSA` | `string` | `"RSA"` | no |
| private_key_rsa_bits | (선택) 알고리즘이 `RSA` 일때, RSA key bits 사이즈 default: `4096` | `number` | `4096` | no |
| public_key | (선택) 공개키 내용. | `string` | `""` | no |
| tags | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
