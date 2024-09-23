output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.test_server.public_ip
}

output "elastic_ip" {
  description = "Elastic IP of the instance"
  value       = aws_eip.eip.public_ip
}

output "ssh_connection_string" {
  description = "SSH connection string to connect to the EC2 instance"
  value       = format("ssh -i %s -o StrictHostKeyChecking=no ubuntu@%s", "griga-key.pem", aws_eip.eip.public_ip)
}

resource "local_file" "inventory_file" {
  content = templatefile("./inventory.template",
    {
      elastic_ip = aws_eip.eip.public_ip
    }
  )
  filename = "./inventory"
}