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

resource "aws_instance" "example" {
  count         = 0
  ami           = "ami-0c2f25c1f66a1ff4d"
  instance_type = "t2.micro"
}