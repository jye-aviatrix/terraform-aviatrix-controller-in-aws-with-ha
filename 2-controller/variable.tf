variable "region" {
  type = string
}
variable "incoming_ssl_cidrs" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "customer_license_id" {
  type = string
}

variable "admin_email" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "access_account_name" {
  type = string
}

variable "access_account_email" {
  type = string
}

variable "key_pair_name" {
  type = string
}
