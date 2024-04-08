locals {
  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a|4g){1}\\..*$/", "1") == "1" ? true : false
  ami                = try(coalesce(var.ami, try(nonsensitive(data.aws_ssm_parameter.this[0].value), null)), null)
}

data "aws_ssm_parameter" "this" {
  count = var.ami == null ? 1 : 0
  name  = var.ami_ssm_parameter
}

###################################################
# EC2 Instance
###################################################
resource "aws_instance" "this" {
  count         = !var.spot_enabled ? 1 : 0
  instance_type = var.instance_type
  ami           = local.ami
  key_name      = var.key_name
  # iam_instance_profile = (try(var.instance_profile.enabled, true)
  #   ? module.instance_profile[0].name
  #   : var.custom_instance_profile
  # )

  # CPU
  cpu_core_count       = try(var.cpu_options.core_count, null)
  cpu_threads_per_core = try(var.cpu_options.threads_per_core, null)

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  # Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  hibernation                          = var.stop_hibernation_enabled
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  # Network
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  associate_public_ip_address = var.auto_assign_public_ip_enabled
  private_ip                  = var.private_ip
  secondary_private_ips       = var.secondary_private_ips

  # Metadata
  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    iterator = metadata

    content {
      http_endpoint               = try(metadata.value.http_endpoint_enabled, true) ? "enabled" : "disabled"
      http_tokens                 = try(metadata.value.http_tokens_enabled, true) ? "required" : "optional"
      http_put_response_hop_limit = try(metadata.value.http_put_response_hop_limit, 1)
      instance_metadata_tags      = try(metadata.value.instance_tags_enabled, true) ? "enabled" : "disabled"
    }
  }

  # Storage
  dynamic "root_block_device" {
    for_each = var.root_block_device

    content {
      delete_on_termination = try(root_block_device.value.delete_on_termination, null)
      encrypted             = try(root_block_device.value.encrypted, null)
      iops                  = try(root_block_device.value.iops, null)
      kms_key_id            = try(root_block_device.value.kms_key_id, null)
      volume_size           = try(root_block_device.value.volume_size, null)
      volume_type           = try(root_block_device.value.volume_type, null)
      throughput            = try(root_block_device.value.throughput, null)
      tags                  = try(root_block_device.value.tags, null)
    }
  }
  tags        = merge({ "Name" = var.name }, var.tags, var.instance_tags)
  volume_tags = var.enable_volume_tags ? merge({ "Name" = var.name }, var.volume_tags) : null
}

###################################################
# EC2 SPOT Instance
###################################################
resource "aws_spot_instance_request" "this" {
  count         = var.spot_enabled ? 1 : 0
  instance_type = var.instance_type
  ami           = local.ami
  key_name      = var.key_name
  # iam_instance_profile = (try(var.instance_profile.enabled, false)
  #   ? module.instance_profile[0].name
  #   : var.custom_instance_profile
  # )

  # CPU
  cpu_core_count       = try(var.cpu_options.core_count, null)
  cpu_threads_per_core = try(var.cpu_options.threads_per_core, null)

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  # Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  hibernation                          = var.stop_hibernation_enabled
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  # Network
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  associate_public_ip_address = var.auto_assign_public_ip_enabled
  private_ip                  = var.private_ip
  secondary_private_ips       = var.secondary_private_ips

  # Metadata
  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    iterator = metadata

    content {
      http_endpoint               = try(metadata.value.http_endpoint_enabled, true) ? "enabled" : "disabled"
      http_tokens                 = try(metadata.value.http_tokens_enabled, true) ? "required" : "optional"
      http_put_response_hop_limit = try(metadata.value.http_put_response_hop_limit, 1)
      instance_metadata_tags      = try(metadata.value.instance_tags_enabled, true) ? "enabled" : "disabled"
    }
  }

  # Storage
  dynamic "root_block_device" {
    for_each = var.root_block_device

    content {
      delete_on_termination = try(root_block_device.value.delete_on_termination, null)
      encrypted             = try(root_block_device.value.encrypted, null)
      iops                  = try(root_block_device.value.iops, null)
      kms_key_id            = try(root_block_device.value.kms_key_id, null)
      volume_size           = try(root_block_device.value.volume_size, null)
      volume_type           = try(root_block_device.value.volume_type, null)
      throughput            = try(root_block_device.value.throughput, null)
      tags                  = try(root_block_device.value.tags, null)
    }
  }
  tags        = merge({ "Name" = var.name }, var.tags, var.instance_tags)
  volume_tags = var.volume_tag_enabled ? merge({ "Name" = var.name }, var.volume_tags) : null
}

###################################################
# EBS Storage
###################################################
resource "aws_ebs_volume" "this" {
  for_each          = var.ebs_block_device
  availability_zone = var.availability_zone
  encrypted         = try(each.value.encrypted, null)
  final_snapshot    = try(each.value.final_snapshot, false)
  iops              = try(each.value.iops, null)
  size              = try(each.value.volume_size, null)
  snapshot_id       = try(each.value.snapshot_id, null)
  type              = try(each.value.volume_type, null)
  throughput        = try(each.value.throughput, null)
  kms_key_id        = try(each.value.kms_key_id, null)

  tags = merge({ Name = "${var.name}-${each.key}" }, var.tags, var.ebs_tags)

  depends_on = [
    aws_instance.this
  ]
}

resource "aws_volume_attachment" "this" {
  for_each    = var.ebs_block_device
  device_name = each.value.device_name
  instance_id = !var.spot_enabled ? aws_instance.this[0].id : aws_spot_instance_request.this[0].id
  volume_id   = aws_ebs_volume.this[each.key].id
}


###################################################
# EC2 Instance State
###################################################
resource "aws_ec2_instance_state" "this" {
  instance_id = !var.spot_enabled ? aws_instance.this[0].id : aws_spot_instance_request.this[0].id
  state       = var.state == "RUNNING" ? "running" : "stopped"
  force       = var.state == "FORCED_STOP"
}

###################################################
# AMI Snapshots from EC2 Instance
###################################################
resource "aws_ami_from_instance" "this" {
  for_each = var.ami_snapshots

  name               = each.key
  description        = var.ami_description
  source_instance_id = !var.spot_enabled ? aws_instance.this[0].id : aws_spot_instance_request.this[0].id

  snapshot_without_reboot = var.ami_snapshots_without_reboot_enabled

  tags = merge(
    {
      "Name" = each.key
    },
    var.ami_tags,
    var.tags,
  )
}

###################################################
# ElasticIP
###################################################
resource "aws_eip" "this" {
  count    = var.eip_enabled ? 1 : 0
  instance = !var.spot_enabled ? aws_instance.this[0].id : aws_spot_instance_request.this[0].id
  tags = merge(
    { "Name" = var.name }, var.tags, var.eip_tags
  )
}
