terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
  profile = "don"
  region  = "ap-south-1"
}

# Boolean variable to toggle SSH access
variable "allow_ssh" {
  description = "Boolean to allow SSH access"
  type        = bool
  default     = false
}

# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Pick the first subnet
data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}

# Create a key pair using your local public key file
resource "aws_key_pair" "aws_key" {
  key_name   = "first-key"
  public_key = file("terr-ec2-key.pub")
}

# Security group with optional SSH access
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh ? ["0.0.0.0/0"] : []
    description = "SSH access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "example" {
  ami                    = "ami-0af9569868786b23a" # Use valid AMI for ap-south-1
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.aws_key.key_name
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Boolean-SSH-Instance"
  }
}
