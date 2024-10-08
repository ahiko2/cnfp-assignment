# terraform backend dyanamoDB
resource "aws_dynamodb_table" "dynamoDB" {
  name           = "dynamo-DB"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

}
