# Define provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

terraform {
  cloud {
    organization = "gfg1234"

    workspaces {
      name = "gfgws"
    }
  }
}


# Create security group for EC2 instances
resource "aws_security_group" "instance_security_group" {
  name_prefix = "instance_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a VPC for the environment
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}





# Create a subnet for the Dev environment
resource "aws_subnet" "dev_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-subnet"
  }
}

# Create a subnet for the Stage environment
resource "aws_subnet" "stage_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "stage-subnet"
  }
}

# Create a subnet for the Prod environment
resource "aws_subnet" "prod_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "prod-subnet"
  }
}

resource "aws_route_table_association" "dev_rta" {

  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "stage_rta" {

  subnet_id      = aws_subnet.stage_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "prod_rta" {

  subnet_id      = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

data "cloudinit_config" "server_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/server.yml", {
      header : aws_security_group.instance_security_group.id
    })
  }
}

# Launch an EC2 instance in the Dev environment
