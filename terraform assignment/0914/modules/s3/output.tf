# output s3 
output "s3" {
  value = aws_s3_bucket.test_bucket.bucket
}