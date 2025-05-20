provider "aws" {
  region = "us-east-1"   # Change to your preferred region
	profile = "don"  # aws configure list-profiles as per also add IAMFULLACCESS permission to user
}

variable "user_names" {
  type    = list(string)
  default = ["user1", "user2"]
}

variable "group_name" {
  type    = string
  default = "developers"
}

# Create IAM Group
resource "aws_iam_group" "this" {
  name = var.group_name
}

# Attach Policy to Group (e.g., ReadOnlyAccess)
resource "aws_iam_group_policy_attachment" "readonly" {
  group      = aws_iam_group.this.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Create Users
resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.key
}

# Add Users to Group
resource "aws_iam_user_group_membership" "membership" {
  for_each = aws_iam_user.users
  user     = each.value.name
  groups   = [aws_iam_group.this.name]
}
