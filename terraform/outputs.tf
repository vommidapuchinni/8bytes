output "public_ip" {
  value = aws_instance.app.public_ip
}

output "ssh_command" {
  value = "ssh -i 8byte-key.pem ubuntu@${aws_instance.app.public_ip}"
}

