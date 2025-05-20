variable "myregion" {
  type    = string
  default = "ap-south-1"
}

variable "i_names" {
  type    = list(string)
  default = ["don-1", "don-2", "don-3"]
}

variable "instance_ty" {
  default = "prod"
}

variable "aminame" {
  type = map(string)
  default = {
    us-east-1  = "ami-084568db4383264d4"
    ap-south-1 = "ami-002f6e91abff6eb96"
  }
}

variable "subnet_ids" {
  type = map(string)
  default = {
    us-east-1  = "subnet-0c49dda88fbd3d486"
    ap-south-1 = "subnet-0484a26353b0a3600"
  }
}

variable "instance_name" {
  type = map(string)
  default = {
    prod   = "t2.micro"
    medium = "t3.medium"
    large  = "t3.large"
  }
}

resource "aws_instance" "myinstances" {
  for_each = toset(var.i_names)

  ami           = var.aminame[var.myregion]
  instance_type = var.instance_name[var.instance_ty]
  subnet_id     = var.subnet_ids[var.myregion]

  tags = {
    Name = each.value
  }
}
