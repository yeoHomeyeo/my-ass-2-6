# New table with the following configuration:
# ● Table Name: <yourname>-bookinventory
# ● Partition Key: ISBN (String)
# ● Sort Key: Genre (String)
# ● Leave all other settings as default.

resource "aws_dynamodb_table" "book-inventory" {

  name = var.my_tablename

  billing_mode = "PROVISIONED" # Important: Set to PROVISIONED

  read_capacity  = 10 # Add this: Choose a value >= 1
  write_capacity = 10 # Add this: Choose a value >= 1

  hash_key  = "ISBN"  # Partition key
  range_key = "Genre" # Sort key

  attribute {
    name = "ISBN"
    type = "S" #String
  }

  attribute {
    name = "Genre"
    type = "S" #String
  }

  tags = {
    Name        = "${var.my_tablename}-bookinventory"
    Environment = var.env # Use a variable for environment
  }

}


#************************************************************************
## Insert data into database not working. TO do so manually
# resource "aws_dynamodb_table_item" "book_inv_1" {
#   table_name = aws_dynamodb_table.book-inventory.name
#   hash_key   = aws_dynamodb_table.book-inventory.hash_key
#   range_key  = aws_dynamodb_table.book-inventory.range_key
#   item = jsonencode(
#     {
#       "ISBN" : { "S" : "978-0134685991" },
#       "Genre" : { "S" : "Technology" },
#       "Title" : { "S" : "Effective Java" },
#       "Author" : { "S" : "Joshua Bloch" },
#       "Stock" : { "N" : "1" }
#     }
#   )
# }

# resource "aws_dynamodb_table_item" "book_inv_2" {
#   table_name = aws_dynamodb_table.book-inventory.name
#   hash_key   = aws_dynamodb_table.book-inventory.hash_key
#   item       = jsonencode(
# {
#   "ISBN": {"S": "978-0134685009"},
#   "Genre": {"S": "Technology"},
#   "Title": {"S": "Learning Python"},
#   "Author": {"S": "Mark Lutz"},
#   "Stock": {"N": "2"}
# }
#)
# 
# }

# resource "aws_dynamodb_table_item" "book_inv_3" {
#   table_name = aws_dynamodb_table.book-inventory.name
#   hash_key   = aws_dynamodb_table.book-inventory.hash_key
#   item       = jsonencode(
# {
#   "ISBN": {"S": "974-0134789698"},
#   "Genre": {"S": "Fiction"},
#   "Title": {"S": "The Hitchhiker"},
#   "Author": {"S": "Douglas Adams"},
#   "Stock": {"N": "10"}
# }
#}
# 
# }

#************************************************************************
## force table into the database
## This doesnt seem to work 
# resource "null_resource" "just-a-ddb-name" {
#   depends_on = [aws_dynamodb_table.book-inventory] # Ensure table exists

#   provisioner "local-exec" {
#     command = <<EOT
#       aws dynamodb put-item \
#         --table-name ${aws_dynamodb_table.book-inventory.name} \
#         --item '{"ISBN": {"S": "978-0134685991"}, "Genre": {"S": "Technology"}, "Title": {"S": "Effective Java"}, "Author": {"S": "Joshua Bloch"}, "Stock": {"N": "1"}}'

#       aws dynamodb put-item \
#         --table-name ${aws_dynamodb_table.book-inventory.name} \
#         --item '{"ISBN": {"S": "978-0134685009"}, "Genre": {"S": "Technology"}, "Title": {"S": "Learning Python"}, "Author": {"S": "Mark Lutz"}, "Stock": {"N": "2"}}'

#       aws dynamodb put-item \
#         --table-name ${aws_dynamodb_table.book-inventory.name} \
#         --item '{"ISBN": {"S": "974-0134789698"}, "Genre": {"S": "Fiction"}, "Title": {"S": "The Hitchhiker"}, "Author": {"S": "Douglas Adams"}, "Stock": {"N": "10"}}'
#     EOT
#   }
# }