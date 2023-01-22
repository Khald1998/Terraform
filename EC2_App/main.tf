# ########
# VPC 
# ########
resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"

    tags = {
    Name = "main VPC"
    }
}
# ########
# internet gateway 
# ########
resource "aws_internet_gateway" "main" {

  vpc_id                          = aws_vpc.main.id

  tags = {
     Name = "internet gateway" 
    }
}
# ########
# subnet 
# ########
resource "aws_subnet" "public_1" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true 
    tags = {
    Name = "public-1"
    }
}

# ########
# security group 
# ########
resource "aws_security_group" "open_door" {
  name = "open door"
  vpc_id = aws_vpc.main.id
  egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      Name = "open door"
  }
}
# ########
# EC2 
# ########
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}