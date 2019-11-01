# Initial configuration

provider "aws" {
  region = "us-east-1"
}


# Basic network
resource "aws_vpc" "vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-k8s-lab"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "172.16.10.0/24"

  tags = {
    Name = "subnet-k8s-public-lab"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "igw-k8s"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "public-route-k8s"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# Basic EC2 k8s-master 

resource "aws_key_pair" "kp_k8s" {
  key_name   = "k8s"
  public_key = "${var.public_key}"
}

resource "aws_security_group" "sg_master" {
  name        = "master-k8s"
  description = "security group para master nodes k8s"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name = "master-k8s"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sgr_master" {
  count       = "${length(var.sg_ingress_ports)}"
  type        = "ingress"
  from_port   = "${element(var.sg_ingress_ports, count.index)}"
  to_port     = "${element(var.sg_ingress_ports, count.index)}"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg_master.id}"
}

resource "aws_instance" "k8s-master" {
  ami             = "ami-04b9e92b5572fa0d1"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.sg_master.id}"]
  subnet_id       = "${aws_subnet.public.id}"
  key_name        = "k8s"
  associate_public_ip_address = true 

  tags = {
    Name = "k8s-master"
  }
}

# ECR for appnode

resource "aws_ecr_repository" "appnode" {
  name                 = "appnode"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}