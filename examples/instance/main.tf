locals {
  region           = "us-ease-1"
  service_code     = "parksm"
  identity_code    = "rnd"
  environment_code = "test"
}

provider "aws" {
  region = local.region
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

module "single_instance" {
  source        = "../../modules/instance"
  name          = "${local.service_code}-${local.identity_code}-${local.environment_code}-01"
  instance_type = "t2.micro"
  ami           = data.aws_ami.amazon_linux2.id
}
