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
# make app 
# ########
resource "null_resource" "main" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {

    command     = <<-EOT
      cd .\Dockerize_me  
      go mod init Dockerize_me
      go mod tidy
      $Env:GOOS = "linux"
      go build main.go
    EOT
    interpreter = ["PowerShell", "-Command"]

  }

}





















# ########
# Docker 
# ########



resource "aws_ecr_repository" "main" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_ecr_authorization_token" "main" {
  # registry_id = aws_ecr_repository.main.registry_id
}

data aws_iam_policy_document ecr_policy {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "*"
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy"
    ]
  }
}

resource aws_ecr_repository_policy main {
  repository = aws_ecr_repository.main.name
  policy = data.aws_iam_policy_document.ecr_policy.json
}



provider "docker" {
  registry_auth {
    address  = local.ecr_address
    username = data.aws_ecr_authorization_token.main.user_name
    password = data.aws_ecr_authorization_token.main.password
  }
}

resource "docker_registry_image" "helloworld" {   
  name          =local.ecr_image_name
  keep_remotely = true

  build {
    context    = "${path.module}/Dockerize_me/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }

  # depends_on = [
  #   docker_image.image
  # ]
}

# resource "docker_image" "image" {
#   name = "test:${local.image_tag}"


#   build {
#     context    = "${path.module}/Dockerize_me/."
#     dockerfile = "Dockerfile"
#     no_cache   = true
#   }
#   depends_on = [aws_ecr_repository.main]
# }
