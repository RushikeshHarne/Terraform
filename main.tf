
variable "myregion" {
   type = string
   default = "ap-south-1"
 }


variable "instance_ty" {
   default = "prod"
 }

variable "aminame" {
 type = map
 default = {
 us-east-1 =  "ami-084568db4383264d4"
 ap-south-1 = "ami-002f6e91abff6eb96"
}
}

variable "subnet_ids" {
  type = map(string)
  default = {
    us-east-1   = "subnet-0c49dda88fbd3d486"       # Replace with valid subnet in us-east-1
    ap-south-1  = "subnet-0484a26353b0a3600"       # Already working subnet
  }
}

variable "instance_name" {
	type = map(string)
	default = { 
	 prod = "t2.micro"
	 medium = "t3.medium"
	 large = "t3.large"
}
}

resource "aws_instance" "myinstance" {
	 ami = var.aminame[var.myregion]
	 instance_type = var.instance_name[var.instance_ty]
	 subnet_id = var.subnet_ids[var.myregion]
	 count = 1

	  tags = {
    Name = "ec2-by-variable"
  }
} 
