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
  key_name      = "griga-key"
  user_data = <<EOF
  #!/bin/bash
  apt update -y
  EOF

  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "GrigaTask"
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH access from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allow 22 port
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH"
  }
}
