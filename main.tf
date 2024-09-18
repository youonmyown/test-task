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

# Elastic IP
resource "aws_eip" "eip" {
  vpc = true
}

# Security Group for SSH and HTTP access
resource "aws_security_group" "web_access" {
  name        = "allow_web_access"
  description = "Allow HTTP and SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowWebAccess"
  }
}


resource "aws_instance" "test_server" {
  ami           = "ami-0e04bcbe83a83792e"
  instance_type = "t2.micro"
  key_name      = "griga-key"

  # provisioner "local-exec" {
  #   command = "bash ./ip_to_inventory.sh"
  # }
  vpc_security_group_ids = [aws_security_group.web_access.id]

  associate_public_ip_address = false

  tags = {
    Name = "GrigaTask"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.test_server.id
  allocation_id = aws_eip.eip.id
}
