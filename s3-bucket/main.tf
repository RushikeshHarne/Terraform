
provider "aws" {
  profile = "don"
  region  = "us-east-1"
}


resource "aws_s3_bucket" "mybucket" {
bucket = "pavan-terraform-accen-01"
acl = "private"
tags = {
Name = "pavan-tf-bucket01"
Environment = "Dev"
}

}
