###################################################
# EC2 Instance
###################################################
variable "name" {
  description = "(필수) 인스턴스 이름"
  type        = string
  nullable    = false
}

variable "state" {
  description = "(선택) 인스턴스 상태 `RUNNING`, `STOPPED` or `FORCED_STOP` default: `RUNNiNT`."
  type        = string
  default     = "RUNNING"
  nullable    = false

  validation {
    condition     = contains(["RUNNING", "STOPPED", "FORCED_STOP"], var.state)
    error_message = "다음 입력 값으로 입력. `RUNNING`, `STOPPED` or `FORCED_STOP`."
  }
}

variable "spot_enabled" {
  description = "(선택) Spot 인스턴스 활성화 default: `false`"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "(선택) 인스턴스 타입 default: `t3.micro`"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "(선택) 인스턴스 이미지 default: `null`"
  type        = string
  default     = null
}

variable "key_name" {
  description = "(선택) 인스턴스 로 Access 할수 있는 SSH Key 이름 default: `null`"
  type        = string
  default     = null
}

variable "cpu_options" {
  description = <<EOF
  (선택) 특정 워크로드 및 비즈니스 요구에 맞게 최적화하기 위한 CPU 옵션 구성 설정. `cpu_options` 블록내용.
    (Optional) `core_count` - 인스턴스 코어수.
    (Optional) `threads_per_core` - 인스턴스 코어당 CPU 스레드 수.
  EOF
  type = object({
    core_count       = number
    threads_per_core = number
  })
  default = null
}

variable "cpu_credits" {
  description = "(선택) CPU credit 옵션, 인스턴스 타입이 T2, T3, T3a 일때 사용 `standard`, `unlimited` T2일경우 기본적으로 `standard` 사용, T3일경우 기본적으로 `unlimited` 를 사용."
  type        = string
  default     = null
}

variable "shutdown_behavior" {
  description = "(선택) 인스턴스의 종료 동작."
  type        = string
  default     = null
}

variable "stop_hibernation_enabled" {
  description = "(선택) 절전모드 활성화."
  type        = bool
  default     = null
}

variable "stop_protection_enabled" {
  description = "(선택) 중지 보호 활성화."
  type        = bool
  default     = false
}

variable "termination_protection_enabled" {
  description = "(선택) 종료 보호 활성화."
  type        = bool
  default     = false
}

variable "monitoring_enabled" {
  description = "(선택) 세부 모니터링 활성화."
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "(선택) 인스턴스를 시작할 AZ."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(선택) 인스턴스 Subnet ID."
  type        = string
  default     = null
}

variable "security_groups" {
  description = "(선택) 인스턴스 보안그룹 리스트"
  type        = set(string)
  default     = []
}

variable "auto_assign_public_ip_enabled" {
  description = "(선택) 자동으로 퍼블릭 IP를 확성화."
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "(선택) 인스턴스 primary IPv4 주소"
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "(선택) secondary private IP 리스트이며 기본 primary 에 보조 프라이빗으로 할당."
  type        = set(string)
  default     = null
}

variable "user_data" {
  description = "(선택) 인스턴스 시작시 제공될 사용자 데이터"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "(선택) 인스턴스 시작시 base64-encode 된 제공될 사용자 데이터"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "(선택) `true` 로 되어있을시 `user_data` or `user_data_base64` 같이 사용하면 destroy 후 재성성. Default: `false`"
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = <<EOF
  (선택) 인스턴스 메타데이터 옵션. `metadata_options` 블록 내용.
    (선택) `http_endpoint_enabled` - 메타 데이터를 사용할수 있는지 여부 default: `true`.
    (선택) `http_tokens_enabled` - 메타 데이터 서비스에 세션 토큰이 필요한지 여부 default: `true`.
    (선택) `http_put_response_hop_limit` - 인스턴스 메타데이터 요청 HTTP PUT 응답 홉 제한. 가능한 값 `1` to `64`. default: `1`.
    (선택) `instance_tags_enabled` - 인스턴스 메타데이터 Tag 엑세스 활성화 default: `true`.
  EOF
  type        = any
  default     = null
}

variable "root_block_device" {
  description = "(선택) 인스턴스 루트 블록 디바이스에 세부정보."
  type        = list(any)
  default     = []
}

variable "ami_ssm_parameter" {
  description = "(선택) AMI ID 에 SSM 파라미터 이름 변수참조 (https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

variable "instance_profile" {
  description = "(선택) 인스턴스 IAM Profile 설정 값."
  type        = string
  default     = null
}

variable "tags" {
  description = "(선택) 리소스 태그 내용"
  type        = map(string)
  default     = {}
}

variable "volume_tag_enabled" {
  description = "(선택) 인스턴스 볼륨 태그 활성화 여부."
  type        = bool
  default     = true
}

###################################################
# EBS Storage
###################################################
variable "ebs_block_device" {
  description = "(선택) 인스턴스 추가 EBS 블록."
  type        = any
  default     = {}
}

###################################################
# AMI Snapshots from EC2 Instance
###################################################
variable "ami_snapshots" {
  description = "(선택) 이미지 AMI 스냅샷 이름 이름은 지역에 고유 이름으로 설정"
  type        = set(string)
  default     = []
  nullable    = false
}

variable "ami_description" {
  description = "(선택) 이미지 설명"
  type        = string
  default     = ""
}

variable "ami_snapshots_without_reboot_enabled" {
  description = "(선택) 이미지 스냅샷 사용시 인스턴스 리부팅 여부"
  type        = bool
  default     = false
  nullable    = false
}

###################################################
# ElasticIP
###################################################
variable "eip_enabled" {
  description = "(선택) Instance 에 Elastic IP 할당 여부"
  type        = bool
  default     = false
}

###################################################
# Default Tags
###################################################
variable "default_tag" {
  description = <<EOF
  (선택) default tag 설정 정보 `default_tag` 블록 내용.
    (선택) `enabled` - default tag 활성화 여부.
    (선택) `security_level` - tag 에 적용될 Security Level 코드. 적용시 `security_level` key 로 설정.
    (선택) `team_code` - tag 에 적용될 Team Code. 적용시 `team_code` key 로 설정.
    (선택) `environment` - tag 에 적용될 환경 Code. 적용시 `environment` key 로 설정.
  EOF
  type = object({
    enabled        = optional(bool, true)
    security_level = optional(string)
    team_code      = optional(string)
    environment    = optional(string)
  })
  default  = {}
  nullable = false
}
