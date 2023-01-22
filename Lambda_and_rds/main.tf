# ########
# VPC 
# ########
resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

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

resource "aws_subnet" "public_2" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true 
    tags = {
    Name = "public-2"
    }
}
# ########
# Publiс routes 
# ########
resource "aws_route_table" "public" {
  vpc_id                          = aws_vpc.main.id
  route {
      cidr_block = "0.0.0.0/0" 
      gateway_id = aws_internet_gateway.main.id
  }
    
    tags = {
        Name = "Main public route"
    }
}

# ########
# Route table association 
# ########

resource "aws_route_table_association" "public_1" {

  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_2" {

  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
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
# DB 
# ########
resource "aws_db_instance" "main" {
  depends_on = [
    aws_security_group.open_door
  ]
    engine               = "mysql"
    engine_version       = "8.0.28"
    identifier = "maindb"
    db_name = "DB"
    username                  = "username"
    password                  = "password"
    instance_class            = "db.t2.micro"
    storage_type = "gp2"
    allocated_storage     = 10
    max_allocated_storage = 20
    vpc_security_group_ids = [aws_security_group.open_door.id]
    db_subnet_group_name = aws_db_subnet_group.main.id
    skip_final_snapshot = true
    publicly_accessible = true
    allow_major_version_upgrade = true

}

resource "aws_db_subnet_group" "main" {
  name       = "subnet group for rds"
  subnet_ids = [aws_subnet.public_1.id,aws_subnet.public_2.id]

  tags = {
    Name = "subnet group for rds"
  }
}
# ########
# lambda 
# ########


resource "aws_lambda_function" "go" {
  function_name = "go_write"
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
