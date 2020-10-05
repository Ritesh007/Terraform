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
  for_each       = var.settings
  ami           = each.value
  instance_type = "t2.micro"
}