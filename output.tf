output "jenkins_public_ip" {
  description = "The ip address for the newly created jenkins instance"
  value       = aws_instance.jenkins_instance.public_ip
}