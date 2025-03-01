variable "myregion_one" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "The environment of the AWS infrastructure"
  type        = string
  default     = "dev"
}

variable "my_inst_type" {
  description = "The environment of the AWS infrastructure"
  type        = string
  default     = "t2.micro"
}

variable "account_id" {
  type    = string
  default = 255945442255
}

variable "my_tablename" {
  type    = string
  default = "chrisy_ddb"
}

variable "my_ddb_role_name" {
  type    = string
  default = "chrisy_ddb_role_name"
}