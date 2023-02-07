output "controller_subnet_ids" {
  value = aws_subnet.aviatrix_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}