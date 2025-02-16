# aws_iam_policy, aws_iam_instance_profile, and aws_instance

#  iam policy
# Create the IAM Policy for DynamoDB "read" operations (items)
resource "aws_iam_policy" "ddb_read_policy" {
  name        = "chrisy-ddb-read-policy"
  description = "Policy for DynamoDB read access (items)"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDynamoDBItemRead"
        Effect = "Allow"
        Action = [
          ## All 28 READ actions
          ## https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazondynamodb.html

          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:Query",
          "dynamodb:Scan", # Use with caution on large tables!
          "dynamodb:ConditionCheckItem",
          "dynamodb:DescribeBackup",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeContributorInsights",
          "dynamodb:DescribeEndpoints",
          "dynamodb:DescribeExport",
          "dynamodb:DescribeGlobalTable",
          "dynamodb:DescribeGlobalTableSettings",
          "dynamodb:DescribeImport",
          "dynamodb:DescribeKinesisStreamingDestination",
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeReservedCapacity",
          "dynamodb:DescribeReservedCapacityOfferings",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTable",
          "dynamodb:DescribeTableReplicaAutoScaling",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:GetAbacStatus",
          "dynamodb:GetRecords",
          "dynamodb:GetResourcePolicy",
          "dynamodb:GetShardIterator",
          "dynamodb:ListStreams",
          "dynamodb:ListTagsOfResource",
          "dynamodb:PartiQLSelect"
        ]
        Resource = [
          "arn:aws:dynamodb:${var.myregion_one}:${var.account_id}:table/${var.my_tablename}"
          #arn:aws:dynamodb:us-east-1:255945442255:table/chrisy_ddb
        ]
      }
    ]
  })
}

# Create the IAM Policy for DynamoDB "list" operations (tables)
resource "aws_iam_policy" "ddb_list_policy" {
  name        = "chrisy-ddb-list-policy"
  description = "Policy for DynamoDB list access (tables)"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDynamoDBTableList"
        Effect = "Allow"
        Action = [
          ## Total 6 actions
          ## https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazondynamodb.html
          "dynamodb:ListTables",
          "dynamodb:ListBackups",
          "dynamodb:ListContributorInsights",
          "dynamodb:ListExports",
          "dynamodb:ListGlobalTables",
          "dynamodb:ListImports"
        ]
        #    Resource = ["*"] # Be cautious about using "*" in production.
        Resource = [
          "arn:aws:dynamodb:${var.myregion_one}:${var.account_id}:table/${var.my_tablename}"
        ]

      }
    ]
  })
}

#  iam role
resource "aws_iam_role" "ddb_role" {

  name = var.my_ddb_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Important: This allows EC2 instances to assume this role
        }
      },
    ]
  })
}

# iam instance profile
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.my_ddb_role_name     # Give it a descriptive name
  role = aws_iam_role.ddb_role.id # Attach the role to the profile
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "iam_ec2_policy_attach1" {
  role       = aws_iam_role.ddb_role.name
  policy_arn = aws_iam_policy.ddb_read_policy.arn
}
resource "aws_iam_role_policy_attachment" "iam_ec2_policy_attach2" {
  role       = aws_iam_role.ddb_role.name
  policy_arn = aws_iam_policy.ddb_list_policy.arn
}