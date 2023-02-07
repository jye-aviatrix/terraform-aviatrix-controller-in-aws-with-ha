resource "aws_cloudformation_stack" "controller_ha" {
  name = "AviatrixControllerHA"

  parameters = {
    VPCParam = var.vpc_id
    SubnetParam = join(",",var.subnet_ids)
    AviatrixTagParam = var.aviatrix_controller_name_tag
    S3BucketBackupParam = var.bucket    
    CustomAviatrixAppRoleName = "aviatrix-role-app"
    CustomAviatrixEC2RoleName = "aviatrix-role-ec2"
    NotifEmailParam = var.notification_email
    PrivateAccess = "False"
  }

  template_body = file("./aviatrix-aws-existing-controller-ha.json")
  capabilities = ["CAPABILITY_NAMED_IAM"]
}