terraform {
  backend "s3" {
    bucket = "terraformdevops-backend"
    key    = "remote_state_terraform.tfstate"
    region = "ca-central-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "ca-central-1"
}

resource "aws_iam_role" "example" {
  name = "example"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "example" {
  role = aws_iam_role.example.name
}

resource "aws_iam_role_policy" "example" {
  name   = "example"
  role   = aws_iam_role.example.name
  policy = jsonencode({
    "Statement" = [{
      "Action" = "s3:*",
      "Effect" = "Allow",
      "Resource" = "*"
    }],
  })
}

resource "aws_instance" "example" {
  ami           = "ami-0c2f25c1f66a1ff4d"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.example.name

  depends_on = [
    aws_iam_role_policy.example,
  ]
}