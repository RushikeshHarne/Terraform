provider "aws" {
  profile = "don"
  region  = "us-east-1"
}

resource "aws_iam_user" "po_user" {
  name = "test1"  # create new user
}

resource "aws_iam_user_policy" "po" {
  name = "test2-policy"				#policy name
  user = aws_iam_user.po_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
