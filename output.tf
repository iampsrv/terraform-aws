output "instance_ip_addr_prod" {
  value       = aws_instance.prod_instance[0].public_ip
  description = "The [public] IP address of the prod instance."
}

output "instance_ip_addr_satge" {
  value       = aws_instance.stage_instance[0].public_ip
  description = "The [public] IP address of the stage instance."
}

output "instance_ip_addr_dev" {
  value       = aws_instance.dev_instance[0].public_ip
  description = "The [public] IP address of the dev instance."
}