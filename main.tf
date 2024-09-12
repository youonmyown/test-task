terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "test_server" {
  ami           = "ami-0584590e5f0e97daa"
  instance_type = "t2.micro"

  tags = {
    Name = "GrigaTask"
  }
}