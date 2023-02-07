variable "region" {
  description = "Provide region to deploy"
  type        = string
  default     = "us-west-1"
}

variable "vpc_id" {
  description = "Provide Aviatrix Controller VPC ID"
  type        = string
}


variable "subnet_ids" {
  description = "Provide list of subnet IDs for Aviatrix controller to be deployed to"
  type        = list(any)
}

variable "aviatrix_controller_name_tag" {
  description = "Enter Name tag of the existing Aviatrix Controller instance."
  type        = string
  default     = "AviatrixController"
}

variable "bucket" {
  description = "Enter S3 Bucket which will be used to store backup files."
  type        = string
}
variable "notification_email" {
  description = "Enter an email to receive notifications for autoscaling group events"
  type        = string
}
