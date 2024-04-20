locals {
  region              = "ap-northeast-2"
  availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnet_count = 2
}

data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

module "vpc" {
  source = "git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/vpc/?ref=tags/1.1.0"
  name   = "parksm-test"
  ipv4_cidrs = [
    {
      cidr = "10.70.0.0/16"
    }
  ]
  internet_gateway = {
    enabled = true
  }
}

module "public_subnet_group" {
  source = "git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/subnet-group/?ref=tags/1.1.0"
  name   = "parksm-test"
  vpc_id = module.vpc.id
  subnets = {
    for idx in range(local.public_subnet_count) : format("parksm-test-public-subnet-0%s", (idx + 1)) => {
      availability_zone = local.availability_zones[idx % length(local.availability_zones)]
      ipv4_cidr         = cidrsubnet("10.70.0.0/16", 8, 10 + idx + 1)
    }
  }
}

module "security_group" {
  source                 = "git::https://github.com/SkylerPark/terraform-aws-vpc-module.git//modules/security-group/?ref=tags/1.1.0"
  name                   = "parksm-test"
  vpc_id                 = module.vpc.id
  revoke_rules_on_delete = true

  ingress_rules = [
    {
      id          = "tcp/80"
      description = "Allow HTTP from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      ipv4_cidrs  = ["192.168.0.0/16", "10.0.0.0/8", "172.168.0.0/24"]
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow all traffics to the internet"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      ipv4_cidrs  = ["0.0.0.0/0"]
    },
  ]
}

module "ssh_key" {
  source             = "../../modules/key-pair"
  name               = "parksm-test"
  create_private_key = true
}

locals {
  instances = {
    "01" = {
      instance_type = "t2.micro"
    }
    "02" = {
      instance_type = "t3.micro"
    }
  }
}

module "instance" {
  source            = "../../modules/instance"
  for_each          = local.instances
  name              = "parksm-rnd-test-${each.key}"
  instance_type     = each.value.instance_type
  key_name          = module.ssh_key.name
  ami               = data.aws_ami.amazon_linux2.id
  availability_zone = local.availability_zones[(index(keys(local.instances), each.key)) % length(local.availability_zones)]
  subnet_id         = module.public_subnet_group.ids[(index(keys(local.instances), each.key)) % length(module.public_subnet_group.ids)]
  security_groups   = [module.security_group.id]

  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 50
      volume_type           = "gp3"
    }
  ]

  metadata_options = {
    http_endpoint_enabled = true
    http_tokens_enabled   = true
    instance_tags_enabled = true
  }

  ebs_block_device = {
    swap = {
      device_name = "/dev/sdb"
      encrypted   = true
      volume_size = 10
      volume_type = "gp3"
    }
  }
}
