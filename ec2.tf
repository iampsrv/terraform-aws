resource "aws_instance" "dev_instance" {
  instance_type               = var.instance_type
  ami                         = var.ami_id
  count                       = var.number_of_instances
  security_groups             = [aws_security_group.instance_security_group.id]
  subnet_id                   = aws_subnet.dev_subnet.id
  user_data                   = data.cloudinit_config.server_config.rendered
  associate_public_ip_address = true

  tags = {
    Name = "dev-instance"
  }
}

# Launch an EC2 instance in the Stage
resource "aws_instance" "stage_instance" {
  instance_type   = var.instance_type
  ami             = var.ami_id
  count           = var.number_of_instances
  security_groups = [aws_security_group.instance_security_group.id]
  subnet_id       = aws_subnet.stage_subnet.id
  user_data       = file("start.sh")

  tags = {
    Name = "stage-instance"
  }
}

# Launch an EC2 instance in the Prod
resource "aws_instance" "prod_instance" {
  instance_type   = var.instance_type
  ami             = var.ami_id
  count           = var.number_of_instances
  security_groups = [aws_security_group.instance_security_group.id]
  subnet_id       = aws_subnet.prod_subnet.id
  user_data       = file("start.sh")

  tags = {
    Name = "prod-instance"
  }
}
