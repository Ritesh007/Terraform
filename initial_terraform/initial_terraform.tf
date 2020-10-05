provider "aws" {
  profile = "default"
  region  = "ca-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-04312317b9c8c4b51"
  instance_type = "t2.micro"
}