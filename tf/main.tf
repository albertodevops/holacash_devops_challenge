resource "aws_vpc" "holacash_devops_vpc" { 
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_subnet" "holacash_devops_vpc_public_subnet_1" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  vpc_id     = aws_vpc.holacash_devops_vpc.id
  cidr_block = "10.200.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_subnet" "holacash_devops_vpc_public_subnet_2" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  vpc_id     = aws_vpc.holacash_devops_vpc.id
  cidr_block = "10.200.11.0/24" 
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_subnet" "holacash_devops_vpc_private_subnet_1" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  vpc_id     = aws_vpc.holacash_devops_vpc.id
  cidr_block = "10.200.20.0/24"
  availability_zone = "us-east-1a"
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_subnet" "holacash_devops_vpc_private_subnet_2" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  vpc_id     = aws_vpc.holacash_devops_vpc.id
  cidr_block = "10.200.21.0/24"
  availability_zone = "us-east-1b"
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_internet_gateway" "holacash_devops_internet_gateway" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  vpc_id = aws_vpc.holacash_devops_vpc.id
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_nat_gateway" "holacash_devops_nat_gateway" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  connectivity_type = "private"
  subnet_id     = aws_subnet.holacash_devops_vpc_public_subnet_1.id
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_route_table" "holacash_devops_route_table" {
  depends_on = [
    aws_vpc.holacash_devops_vpc,
    aws_internet_gateway.holacash_devops_internet_gateway
  ]
  vpc_id = aws_vpc.holacash_devops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.holacash_devops_internet_gateway.id
  }
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_route_table_association" "holacash_devops_route_table_association_1" {
  depends_on = [
    aws_subnet.holacash_devops_vpc_public_subnet_1,
    aws_route_table.holacash_devops_route_table
  ]
  subnet_id      = aws_subnet.holacash_devops_vpc_public_subnet_1.id
  route_table_id = aws_route_table.holacash_devops_route_table.id
}

resource "aws_route_table_association" "holacash_devops_route_table_association_2" {
  depends_on = [
    aws_subnet.holacash_devops_vpc_public_subnet_2,
    aws_route_table.holacash_devops_route_table
  ]
  subnet_id      = aws_subnet.holacash_devops_vpc_public_subnet_2.id
  route_table_id = aws_route_table.holacash_devops_route_table.id
}

resource "aws_security_group" "holacash_devops_bastion-sg" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  name   = "holacash_devops_bastion-sg"
  description = "holacash_devops_bastion-sg Security Group allow SSH Protocol"
  vpc_id = "${aws_vpc.holacash_devops_vpc.id}"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "output to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_security_group" "holacash_devops_nginx-sg" {
  depends_on = [aws_vpc.holacash_devops_vpc]
  name   = "holacash_devops_nginx-sg"
  description = "holacash_devops_nginx-sg Security Group Allow web access"
  vpc_id = "${aws_vpc.holacash_devops_vpc.id}"

  ingress {
    description = "Bastion access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_vpc]
  }
  ingress {
    description = "input web access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "output to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_instance" "holacash_devops_bastion_instance" {
  ami                         = var.ami_base
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.holacash_devops_vpc_public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.holacash_devops_bastion-sg.id]
  associate_public_ip_address = true
  private_ip                  = "10.200.10.100"
  user_data                   = data.template_file.holacash_devops_user_data_bastion.rendered
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_elb" "holacash_devops_elb" {
  depends_on = [aws_subnet.holacash_devops_vpc_public_subnet_1,aws_subnet.holacash_devops_vpc_public_subnet_2]
  name = "holacashdevopselb"
  security_groups = [aws_security_group.holacash_devops_nginx-sg.id]
  subnets  = [aws_subnet.holacash_devops_vpc_public_subnet_1.id,aws_subnet.holacash_devops_vpc_public_subnet_2.id]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 60
    interval = 61
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
  tags = {
    holacash-logical_environment = var.logical_environment
    holacash-generation_method = var.generation_method
    Candidate = var.candidate
  }
}

resource "aws_launch_configuration" "holacash_devops_nginx_lc" {
  image_id               = var.ami_base
  name_prefix            = "holacash_devops_nginx-"
  instance_type          = "t2.small"
  security_groups        = [aws_security_group.holacash_devops_nginx-sg.id]
  user_data              = data.template_file.holacash_devops_user_data_nginx.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "holacash_devops_autoscaling_group" {
  launch_configuration = "${aws_launch_configuration.holacash_devops_nginx_lc.id}"
  vpc_zone_identifier  = [aws_subnet.holacash_devops_vpc_public_subnet_1.id, aws_subnet.holacash_devops_vpc_public_subnet_2.id]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.holacash_devops_elb.name}"]
  health_check_type = "ELB"
}
