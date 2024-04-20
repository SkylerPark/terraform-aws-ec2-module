# instance

## 기능

인스턴스 생성

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ami_from_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance) | resource |
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_ec2_instance_state.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_state) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_spot_instance_request.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ec2_instance_type.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type) | data source |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | (선택) 인스턴스 이미지 default: `null` | `string` | `null` | no |
| <a name="input_ami_description"></a> [ami\_description](#input\_ami\_description) | (선택) 이미지 설명 | `string` | `""` | no |
| <a name="input_ami_snapshots"></a> [ami\_snapshots](#input\_ami\_snapshots) | (선택) 이미지 AMI 스냅샷 이름 이름은 지역에 고유 이름으로 설정 | `set(string)` | `[]` | no |
| <a name="input_ami_snapshots_without_reboot_enabled"></a> [ami\_snapshots\_without\_reboot\_enabled](#input\_ami\_snapshots\_without\_reboot\_enabled) | (선택) 이미지 스냅샷 사용시 인스턴스 리부팅 여부 | `bool` | `false` | no |
| <a name="input_ami_ssm_parameter"></a> [ami\_ssm\_parameter](#input\_ami\_ssm\_parameter) | (선택) AMI ID 에 SSM 파라미터 이름 변수참조 (https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html) | `string` | `"/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"` | no |
| <a name="input_ami_tags"></a> [ami\_tags](#input\_ami\_tags) | (선택) AMI 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_auto_assign_public_ip_enabled"></a> [auto\_assign\_public\_ip\_enabled](#input\_auto\_assign\_public\_ip\_enabled) | (선택) 자동으로 퍼블릭 IP를 확성화. | `bool` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (선택) 인스턴스를 시작할 AZ. | `string` | `null` | no |
| <a name="input_cpu_credits"></a> [cpu\_credits](#input\_cpu\_credits) | (선택) CPU credit 옵션, 인스턴스 타입이 T2, T3, T3a 일때 사용 `standard`, `unlimited` T2일경우 기본적으로 `standard` 사용, T3일경우 기본적으로 `unlimited` 를 사용. | `string` | `null` | no |
| <a name="input_cpu_options"></a> [cpu\_options](#input\_cpu\_options) | (선택) 특정 워크로드 및 비즈니스 요구에 맞게 최적화하기 위한 CPU 옵션 구성 설정. `cpu_options` 블록내용.<br>    (Optional) `core_count` - 인스턴스 코어수.<br>    (Optional) `threads_per_core` - 인스턴스 코어당 CPU 스레드 수. | <pre>object({<br>    core_count       = number<br>    threads_per_core = number<br>  })</pre> | `null` | no |
| <a name="input_custom_instance_profile"></a> [custom\_instance\_profile](#input\_custom\_instance\_profile) | (선택) 인스턴스 프로파일을 생성하지 않을경우 이름 | `string` | `null` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | (선택) 인스턴스 추가 EBS 블록. | `any` | `{}` | no |
| <a name="input_ebs_tags"></a> [ebs\_tags](#input\_ebs\_tags) | (선택) EBS 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_eip_enabled"></a> [eip\_enabled](#input\_eip\_enabled) | (선택) Instance 에 Elastic IP 할당 여부 | `bool` | `false` | no |
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | (선택) ElasticIP 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | (선택) 인스턴스 프로파일 설정 `instance_profile` 블록 내용.<br>    (선택) `enabled` - 인스턴스 프로파일 IAM role 생성 여부 default: `false`.<br>    (선택) `name` - IAM role 이름.<br>    (선택) `path` - IAM role Path.<br>    (선택) `description` - IAM Role 설명.<br>    (선택) `assumable_roles` - 역할이 맡을 수 있는 IAM 역할 ARN 목록.<br>    (선택) `policies` - IAM 역할에 연결할 IAM 정책 ARN 목록.<br>    (선택) `inline_policies` - IAM 역할에 연결할 인라인 IAM 정책 맵. (`name` => `policy`). | `any` | `null` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | (선택) 인스턴스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (선택) 인스턴스 타입 default: `t3.micro` | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | (선택) 인스턴스 로 Access 할수 있는 SSH Key 이름 default: `null` | `string` | `null` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | (선택) 인스턴스 메타데이터 옵션. `metadata_options` 블록 내용.<br>    (선택) `http_endpoint_enabled` - 메타 데이터를 사용할수 있는지 여부 default: `true`.<br>    (선택) `http_tokens_enabled` - 메타 데이터 서비스에 세션 토큰이 필요한지 여부 default: `true`.<br>    (선택) `http_put_response_hop_limit` - 인스턴스 메타데이터 요청 HTTP PUT 응답 홉 제한. 가능한 값 `1` to `64`. default: `1`.<br>    (선택) `instance_tags_enabled` - 인스턴스 메타데이터 Tag 엑세스 활성화 default: `true`. | `any` | `null` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | (선택) 세부 모니터링 활성화. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) 인스턴스 이름 | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | (선택) 인스턴스 primary IPv4 주소 | `string` | `null` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | (선택) 인스턴스 루트 블록 디바이스에 세부정보. | `list(any)` | `[]` | no |
| <a name="input_secondary_private_ips"></a> [secondary\_private\_ips](#input\_secondary\_private\_ips) | (선택) secondary private IP 리스트이며 기본 primary 에 보조 프라이빗으로 할당. | `set(string)` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (선택) 인스턴스 보안그룹 리스트 | `set(string)` | `[]` | no |
| <a name="input_shutdown_behavior"></a> [shutdown\_behavior](#input\_shutdown\_behavior) | (선택) 인스턴스의 종료 동작. | `string` | `null` | no |
| <a name="input_spot_enabled"></a> [spot\_enabled](#input\_spot\_enabled) | (선택) Spot 인스턴스 활성화 default: `false` | `bool` | `false` | no |
| <a name="input_state"></a> [state](#input\_state) | (선택) 인스턴스 상태 `RUNNING`, `STOPPED` or `FORCED_STOP` default: `RUNNiNT`. | `string` | `"RUNNING"` | no |
| <a name="input_stop_hibernation_enabled"></a> [stop\_hibernation\_enabled](#input\_stop\_hibernation\_enabled) | (선택) 절전모드 활성화. | `bool` | `null` | no |
| <a name="input_stop_protection_enabled"></a> [stop\_protection\_enabled](#input\_stop\_protection\_enabled) | (선택) 중지 보호 활성화. | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (선택) 인스턴스 Subnet ID. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | (선택) 종료 보호 활성화. | `bool` | `false` | no |
| <a name="input_volume_tag_enabled"></a> [volume\_tag\_enabled](#input\_volume\_tag\_enabled) | (선택) 인스턴스 볼륨 태그 활성화 여부. | `bool` | `true` | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | (선택) 인스턴스 DISK 태그 내용 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | 인스턴스 Availability Zone |
| <a name="output_cpu"></a> [cpu](#output\_cpu) | 인스턴스 CPU |
| <a name="output_disk"></a> [disk](#output\_disk) | 인스턴스 DISK |
| <a name="output_id"></a> [id](#output\_id) | 인스턴스 UUID |
| <a name="output_memory"></a> [memory](#output\_memory) | 인스턴스 Memory (GiB) |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | 인스턴스 Private IP |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | 인스턴스 Public IP |
| <a name="output_state"></a> [state](#output\_state) | 인스턴스 상태 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 1.0    |
| aws       | >= 4.20.0 |

### Providers

| Name | Version   |
| ---- | --------- |
| aws  | >= 4.20.0 |

### Modules

No modules.

### Resources

| Name                                                                                                                                | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_ami_from_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance)         | resource    |
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume)                       | resource    |
| [aws_ec2_instance_state.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_state)       | resource    |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                           | resource    |
| [aws_spot_instance_request.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource    |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment)         | resource    |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)              | data source |

### Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Type                                                                             | Required |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | :------: |
| name                                 | (필수) 인스턴스 이름                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `string`                                                                         |   yes    |
| ami                                  | (선택) 인스턴스 이미지 default: `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `string`                                                                         |    no    |
| ami_description                      | (선택) 이미지 설명                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `string`                                                                         |    no    |
| ami_snapshots                        | (선택) 이미지 AMI 스냅샷 이름 이름은 지역에 고유 이름으로 설정                                                                                                                                                                                                                                                                                                                                                                                                                          | `set(string)`                                                                    |    no    |
| ami_snapshots_without_reboot_enabled | (선택) 이미지 스냅샷 사용시 인스턴스 리부팅 여부                                                                                                                                                                                                                                                                                                                                                                                                                                        | `bool`                                                                           |    no    |
| ami_ssm_parameter                    | (선택) AMI ID 에 SSM 파라미터 이름 변수참조 (https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)                                                                                                                                                                                                                                                                                                                                   | `string`                                                                         |    no    |
| ami_tags                             | (선택) AMI 태그 내용                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `map(string)`                                                                    |    no    |
| auto_assign_public_ip_enabled        | (선택) 자동으로 퍼블릭 IP를 확성화.                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `bool`                                                                           |    no    |
| availability_zone                    | (선택) 인스턴스를 시작할 AZ.                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `string`                                                                         |    no    |
| cpu_credits                          | (선택) CPU credit 옵션, 인스턴스 타입이 T2, T3, T3a 일때 사용 `standard`, `unlimited` T2일경우 기본적으로 `standard` 사용, T3일경우 기본적으로 `unlimited` 를 사용.                                                                                                                                                                                                                                                                                                                     | `string`                                                                         |    no    |
| cpu_options                          | (선택) 특정 워크로드 및 비즈니스 요구에 맞게 최적화하기 위한 CPU 옵션 구성 설정. `cpu_options` 블록내용.<br> (Optional) `core_count` - 인스턴스 코어수.<br> (Optional) `threads_per_core` - 인스턴스 코어당 CPU 스레드 수.                                                                                                                                                                                                                                                              | <pre>object({<br> core_count = number<br> threads_per_core = number<br> })</pre> |    no    |
| custom_instance_profile              | (선택) 인스턴스 프로파일을 생성하지 않을경우 이름                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`                                                                         |    no    |
| ebs_block_device                     | (선택) 인스턴스 추가 EBS 블록.                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `map(string)`                                                                    |    no    |
| ebs_tags                             | (선택) EBS 태그 내용                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `map(string)`                                                                    |    no    |
| instance_profile                     | (선택) 인스턴스 프로파일 설정 `instance_profile` 블록 내용.<br> (선택) `enabled` - 인스턴스 프로파일 IAM role 생성 여부 default: `false`.<br> (선택) `name` - IAM role 이름.<br> (선택) `path` - IAM role Path.<br> (선택) `description` - IAM Role 설명.<br> (선택) `assumable_roles` - 역할이 맡을 수 있는 IAM 역할 ARN 목록.<br> (선택) `policies` - IAM 역할에 연결할 IAM 정책 ARN 목록.<br> (선택) `inline_policies` - IAM 역할에 연결할 인라인 IAM 정책 맵. (`name` => `policy`). | `any`                                                                            |    no    |
| instance_tags                        | (선택) 인스턴스 태그 내용                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `map(string)`                                                                    |    no    |
| instance_type                        | (선택) 인스턴스 타입 default: `t3.micro`                                                                                                                                                                                                                                                                                                                                                                                                                                                | `string`                                                                         |    no    |
| key_name                             | (선택) 인스턴스 로 Access 할수 있는 SSH Key 이름 default: `null`                                                                                                                                                                                                                                                                                                                                                                                                                        | `string`                                                                         |    no    |
| metadata_options                     | (선택) 인스턴스 메타데이터 옵션. `metadata_options` 블록 내용.<br> (선택) `http_endpoint_enabled` - 메타 데이터를 사용할수 있는지 여부 default: `true`.<br> (선택) `http_tokens_enabled` - 메타 데이터 서비스에 세션 토큰이 필요한지 여부 default: `true`.<br> (선택) `http_put_response_hop_limit` - 인스턴스 메타데이터 요청 HTTP PUT 응답 홉 제한. 가능한 값 `1` to `64`. default: `1`.<br> (선택) `instance_tags_enabled` - 인스턴스 메타데이터 Tag 엑세스 활성화 default: `true`.  | `any`                                                                            |    no    |
| monitoring_enabled                   | (선택) 세부 모니터링 활성화.                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `bool`                                                                           |    no    |
| private_ip                           | (선택) 인스턴스 primary IPv4 주소                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`                                                                         |    no    |
| root_block_device                    | (선택) 인스턴스 루트 블록 디바이스에 세부정보.                                                                                                                                                                                                                                                                                                                                                                                                                                          | `list(any)`                                                                      |    no    |
| secondary_private_ips                | (선택) secondary private IP 리스트이며 기본 primary 에 보조 프라이빗으로 할당.                                                                                                                                                                                                                                                                                                                                                                                                          | `set(string)`                                                                    |    no    |
| security_groups                      | (선택) 인스턴스 보안그룹 리스트                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `set(string)`                                                                    |    no    |
| shutdown_behavior                    | (선택) 인스턴스의 종료 동작.                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `string`                                                                         |    no    |
| spot_enabled                         | (선택) Spot 인스턴스 활성화 default: `false`                                                                                                                                                                                                                                                                                                                                                                                                                                            | `bool`                                                                           |    no    |
| state                                | (선택) 인스턴스 상태 `RUNNING`, `STOPPED` or `FORCED_STOP` default: `RUNNiNT`.                                                                                                                                                                                                                                                                                                                                                                                                          | `string`                                                                         |    no    |
| stop_hibernation_enabled             | (선택) 절전모드 활성화.                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `bool`                                                                           |    no    |
| stop_protection_enabled              | (선택) 중지 보호 활성화.                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `bool`                                                                           |    no    |
| subnet_id                            | (선택) 인스턴스 Subnet ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `string`                                                                         |    no    |
| tags                                 | (선택) 리소스 태그 내용                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `map(string)`                                                                    |    no    |
| termination_protection_enabled       | (선택) 종료 보호 활성화.                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `bool`                                                                           |    no    |

### Outputs

No outputs.

<!-- END_TF_DOCS -->
