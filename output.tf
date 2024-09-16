output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.test_server.public_ip
}

output "ssh_connection_string" {
  description = "SSH connection string to connect to the EC2 instance"
  value       = format("ssh -i %s -o StrictHostKeyChecking=no admin@%s", "griga-key.pem", aws_instance.test_server.public_ip)
}