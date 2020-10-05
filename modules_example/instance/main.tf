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

module instance {
    source          = "../modules/ec2" 
    image_id        = "ami-0c2f25c1f66a1ff4d"
    instance_type   = "t2.micro"
}

module iam_role {
    source          = "../modules/iam" 
}