# ########
# VPC 
# ########
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main VPC"
  }
}
# ########
# internet gateway 
# ########
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet gateway"
  }
}
# ########
# subnet 
# ########
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1"
  }
}


resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

}
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.main_route.id
}

# ########
# security group 
# ########
resource "aws_security_group" "open_door" {
  name   = "open door"
  vpc_id = aws_vpc.main.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "open door"
  }
}

resource "aws_security_group" "instance" {
  name   = "shh"
  vpc_id = aws_vpc.main.id

  ingress { //shh
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { //http
    from_port   = 80
    to_port     = 80
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


resource "aws_instance" "main" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.open_door.id]
  key_name                    = "main_key"
  associate_public_ip_address = true
  user_data                   = file("user_data.sh")

  tags = {
    Name = "HelloWorld"
  }

}
# ########
# lambda 
# ########


resource "aws_lambda_function" "main" {
  function_name = "go_func"
  filename         = data.archive_file.go.output_path
  source_code_hash = data.archive_file.go.output_base64sha256
  role    = aws_iam_role.role_for_lambda.arn
  handler = "main"
  runtime = "go1.x"
    environment {
    variables = {
      rds_password = aws_db_instance.main.password
      rds_username = aws_db_instance.main.username
      rds_port = aws_db_instance.main.port
      rds_endpoint = aws_db_instance.main.address
      rds_db_name = aws_db_instance.main.db_name

    }
  }
}

resource "aws_iam_role" "role_for_lambda" {
    name               = "Our_iam_role_for_lambda"
    assume_role_policy = data.aws_iam_policy_document.role.json
}

resource "aws_iam_role_policy" "lambda_policy" {
    name = "Our_lambda_policy"
    role = aws_iam_role.role_for_lambda.id
    policy = data.aws_iam_policy_document.policy_for_lambda.json
}
