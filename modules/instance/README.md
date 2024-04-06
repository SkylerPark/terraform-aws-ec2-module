# instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | (필수) 인스턴스 이름 | `string` | n/a | yes |
| ami | (선택) 인스턴스 이미지 default: `null` | `string` | `null` | no |
| ami_description | (선택) 이미지 설명 | `string` | `""` | no |
| ami_snapshots | (선택) 이미지 AMI 스냅샷 이름 이름은 지역에 고유 이름으로 설정 | `set(string)` | `[]` | no |
| ami_snapshots_without_reboot_enabled | (선택) 이미지 스냅샷 사용시 인스턴스 리부팅 여부 | `bool` | `false` | no |
| ami_ssm_parameter | (선택) AMI ID 에 SSM 파라미터 이름 변수참조 (https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html) | `string` | `"/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"` | no |
| ami_tags | (선택) AMI 태그 내용 | `map(string)` | `{}` | no |
| auto_assign_public_ip_enabled | (선택) 자동으로 퍼블릭 IP를 확성화. | `bool` | `null` | no |
| availability_zone | (선택) 인스턴스를 시작할 AZ. | `string` | `null` | no |
| cpu_credits | (선택) CPU credit 옵션, 인스턴스 타입이 T2, T3, T3a 일때 사용 `standard`, `unlimited` T2일경우 기본적으로 `standard` 사용, T3일경우 기본적으로 `unlimited` 를 사용. | `string` | `null` | no |
| cpu_options | (선택) 특정 워크로드 및 비즈니스 요구에 맞게 최적화하기 위한 CPU 옵션 구성 설정. `cpu_options` 블록내용.<br>    (Optional) `core_count` - 인스턴스 코어수.<br>    (Optional) `threads_per_core` - 인스턴스 코어당 CPU 스레드 수. | <pre>object({<br>    core_count       = number<br>    threads_per_core = number<br>  })</pre> | `null` | no |
| custom_instance_profile | (선택) 인스턴스 프로파일을 생성하지 않을경우 이름 | `string` | `null` | no |
| ebs_block_device | (선택) 인스턴스 추가 EBS 블록. | `map(string)` | `{}` | no |
| ebs_tags | (선택) EBS 태그 내용 | `map(string)` | `{}` | no |
| instance_profile | (선택) 인스턴스 프로파일 설정 `instance_profile` 블록 내용.<br>    (선택) `enabled` - 인스턴스 프로파일 IAM role 생성 여부 default: `false`.<br>    (선택) `name` - IAM role 이름.<br>    (선택) `path` - IAM role Path.<br>    (선택) `description` - IAM Role 설명.<br>    (선택) `assumable_roles` - 역할이 맡을 수 있는 IAM 역할 ARN 목록.<br>    (선택) `policies` - IAM 역할에 연결할 IAM 정책 ARN 목록.<br>    (선택) `inline_policies` - IAM 역할에 연결할 인라인 IAM 정책 맵. (`name` => `policy`). | `any` | `null` | no |
| instance_tags | (선택) 인스턴스 태그 내용 | `map(string)` | `{}` | no |
| instance_type | (선택) 인스턴스 타입 default: `t3.micro` | `string` | `"t3.micro"` | no |
| key_name | (선택) 인스턴스 로 Access 할수 있는 SSH Key 이름 default: `null` | `string` | `null` | no |
| metadata_options | (선택) 인스턴스 메타데이터 옵션. `metadata_options` 블록 내용.<br>    (선택) `http_endpoint_enabled` - 메타 데이터를 사용할수 있는지 여부 default: `true`.<br>    (선택) `http_tokens_enabled` - 메타 데이터 서비스에 세션 토큰이 필요한지 여부 default: `true`.<br>    (선택) `http_put_response_hop_limit` - 인스턴스 메타데이터 요청 HTTP PUT 응답 홉 제한. 가능한 값 `1` to `64`. default: `1`.<br>    (선택) `instance_tags_enabled` - 인스턴스 메타데이터 Tag 엑세스 활성화 default: `true`. | `any` | `null` | no |
| monitoring_enabled | (선택) 세부 모니터링 활성화. | `bool` | `false` | no |
| private_ip | (선택) 인스턴스 primary IPv4 주소 | `string` | `null` | no |
| root_block_device | (선택) 인스턴스 루트 블록 디바이스에 세부정보. | `list(any)` | `[]` | no |
| secondary_private_ips | (선택) secondary private IP 리스트이며 기본 primary 에 보조 프라이빗으로 할당. | `set(string)` | `null` | no |
| security_groups | (선택) 인스턴스 보안그룹 리스트 | `set(string)` | `[]` | no |
| shutdown_behavior | (선택) 인스턴스의 종료 동작. | `string` | `null` | no |
| spot_enabled | (선택) Spot 인스턴스 활성화 default: `false` | `bool` | `false` | no |
| state | (선택) 인스턴스 상태 `RUNNING`, `STOPPED` or `FORCED_STOP` default: `RUNNiNT`. | `string` | `"RUNNING"` | no |
| stop_hibernation_enabled | (선택) 절전모드 활성화. | `bool` | `null` | no |
| stop_protection_enabled | (선택) 중지 보호 활성화. | `bool` | `false` | no |
| subnet_id | (선택) 인스턴스 Subnet ID. | `string` | `null` | no |
| tags | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |
| termination_protection_enabled | (선택) 종료 보호 활성화. | `bool` | `false` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
