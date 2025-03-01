## Assignment 2-6

###  In IAM policy, assigned only chrisy_ddb ARN for list policy, as such, cannot list all tables
```
Resource = [
          "arn:aws:dynamodb:${var.myregion_one}:${var.account_id}:table/${var.my_tablename}"
```
###  To allow listtables ~ list all table in the account & region
```
 Resource = ["*"]
```
