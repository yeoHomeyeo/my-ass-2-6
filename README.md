## Assignment 2-6

###  In IAM policy, assigned only chrisyddb ARN for list policy, as such, cannot list all tables
```
Resource = [
          "arn:aws:dynamodb:${var.myregion_one}:${var.account_id}:table/${var.my_tablename}"
```
          
