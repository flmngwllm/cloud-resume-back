resource "aws_dynamodb_table" "web_visit" {
  name           = "web_visitors"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Visitors"
  range_key      = ""

  attribute {
    name = "Visitors"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "web-visitor-table"
    Environment = "production"
  }
}


resource "aws_dynamodb_table_item" "web_count" {
  table_name = aws_dynamodb_table.web_visit.name
  hash_key   = aws_dynamodb_table.web_visit.hash_key

  item = <<ITEM
{
  "Visitors": {"N": "0"} 
}
ITEM
}

