# terraform backup s3
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "elli-terraform-backend"
}
resource "aws_s3_bucket_versioning" "tf_bucket" {
  bucket = aws_s3_bucket.tf_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#bucket 1
resource "aws_s3_bucket" "test_bucket" {
  bucket = "bucket-elli"
}