locals {
  instance = try(aws_instance.this[0], aws_spot_instance_request.this[0])
}

data "aws_ec2_instance_type" "this" {
  instance_type = var.instance_type
}

output "id" {
  description = "인스턴스 UUID"
  value       = local.instance.id
}

output "state" {
  description = "인스턴스 상태"
  value       = local.instance.instance_state
}

output "private_ip" {
  description = "인스턴스 Private IP"
  value       = local.instance.private_ip
}

output "availability_zone" {
  description = "인스턴스 Availability Zone"
  value       = local.instance.availability_zone
}

output "public_ip" {
  description = "인스턴스 Public IP"
  value       = var.eip_enabled ? aws_eip.this[0].id : local.instance.public_ip
}

output "disk" {
  description = "인스턴스 DISK"
  value = concat(
    [
      for disk in var.root_block_device :
      "vHDD / ${disk.volume_size}"
    ],
    [
      for k, disk in var.ebs_block_device :
      "vHDD / ${disk.volume_size}"
    ]
  )
}

output "cpu" {
  description = "인스턴스 CPU"
  value       = data.aws_ec2_instance_type.this.default_vcpus
}

output "memory" {
  description = "인스턴스 Memory (GiB)"
  value       = data.aws_ec2_instance_type.this.memory_size / 1024
}
