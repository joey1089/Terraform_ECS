
terraform {
  backend "s3" {
    bucket                  = "mybucket-4-state-store"
    dynamodb_table          = "state_dbtable_name"
    key                     = "terraform-state-store"
    # region                  = "us-east-1"
    # shared_credentials_file = "~/.aws/credentials"
  }
}

# provider "aws" {
#   region                  = "us-east-1"
#   shared_credentials_file = "~/.aws/credentials"
# }


resource "aws_s3_bucket" "bucket_name_state" {
  bucket = "terraform-state-store-secure0001"
  acl    = "private"

  tags = {
    Name = "myBucketTagName"
  }
}

#   acl    = "private"

#   tags = {
#     Name = "myBucketTagName"
#   }
# }

resource "aws_s3_bucket" "simple_bucket2" {
  bucket = "terraform-s3-state-02231"
  acl    = "private"

  tags = {
    Name = "myBucketTagName"
  }
}