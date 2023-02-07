resource "random_id" "unique_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.s3_bucket_prefix}-${random_id.unique_id.hex}"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}