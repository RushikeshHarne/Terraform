provider "aws" {
  profile = "don"
  region  = "ap-south-1"
}

resource "aws_instance" "myinstance" {
	 ami = "ami-002f6e91abff6eb96"
	 instance_type = "t2.micro"
	 subnet_id = "subnet-0484a26353b0a3600"
	 count = 1

	  tags = {
    Name = "tf-example"
  }
}
