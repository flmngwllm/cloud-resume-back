resource "aws_dynamodb_table" "web_visit" {
  name           = "web_visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "visitor_id"
  

  attribute {
    name = "visitor_id"
    type = "N"
  }

  attribute {
    name = "visit_count"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
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
  "visitor_id": {"N": "1"},
  "visit_count": {"N": "0"} 
}
ITEM
}

