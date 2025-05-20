provider "aws" {
	profile = "don"
  region = "ap-south-1"  # Change to your preferred region
}

variable "vpc_n" {
	type = string
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.vpc_n}"
  }
}
