
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "aws-controller" {
  source  = "AviatrixSystems/aws-controller/aviatrix"
  version = "1.0.3"
  incoming_ssl_cidrs = var.incoming_ssl_cidrs
  admin_email = var.admin_email
  admin_password = var.admin_password
  access_account_name = var.access_account_name
  access_account_email = var.access_account_email
  create_iam_roles = false
  use_existing_vpc = true
  vpc_id = var.vpc_id
  subnet_id = var.subnet_id
  use_existing_keypair = true
  key_pair_name = var.key_pair_name
  customer_license_id = var.customer_license_id
}

output "controller" {
  value = module.aws-controller
}