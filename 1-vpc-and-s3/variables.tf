variable "region" {
  description = "Provide region to deploy"
  type = string
  default = "us-west-1"
}

variable "vpc_name" {
  description = "Provide VPC name"
  type = string
  default = "Aviatrix"
}

variable "vpc_cidr" {
  description = "Provide VPC CIDR"
  type = string
  default = "10.0.0.0/24"
}

variable "vpc_azs" {
  description = "Provide list of two aviability zones"
  type = list
  default = ["us-west-1a","us-west-1b"]
}

variable "aviatrix_subnets" {
  description = "Provide list of two CIDRs for public subnets, Aviatrix Controller will be deployed to these /28 public subnets"
  type = list
  default = ["10.0.0.0/28","10.0.0.16/28"]
}

variable "spoke_gw_subnets" {
  description = "Provide list of two CIDRs for spoke gateways, for on-prem connectivity, Aviatrix Spoke Gateway (none-hpe) to be deployed these /28 public subnets"
  type = list
  default = ["10.0.0.32/28","10.0.0.48/28"]
}

variable "ilb_subnets" {
  description = "Provide list of two CIDRs for ILB (internal network load balancer). When Aviatirx HA is enabled, it will be part of Auto Scaling Group, where private IP will change during fail over. ILB will provide a consistent private IP for on-prem access "
  type = list
  default = ["10.0.0.64/28","10.0.0.80/28"]
}

variable "s3_bucket_prefix" {
  description = "Provide S3 bucket name prefix"
  type = string
  default = "aviatrix-controller-s3-backup"
}