# README

## Title
Deploying a Simple Webserver on AWS using Terraform and Bash

## Background
This project aims to provide a simplified and efficient process to deploy a basic web server on an AWS EC2 instance using Terraform and Bash script. With the help of the Infrastructure as Code (IAC) tool, Terraform, we set up an environment in AWS which includes the creation of a VPC, an internet gateway, a subnet, route table, security groups, and an EC2 instance. A Bash script is used to install Apache on the EC2 instance and display a simple webpage.

## Prerequisites
To use these scripts, you need to have the following installed/configured on your system:
- AWS account and your AWS credentials set up on your machine (typically in `~/.aws/credentials`).
- [Terraform](https://www.terraform.io/downloads.html) version that is compatible with the AWS provider used in the script (as of my knowledge cutoff in September 2021, Terraform 0.13.x should work).
- [Bash](https://www.gnu.org/software/bash/) shell in your system for executing the script. For Windows users, you can use Git Bash or WSL (Windows Subsystem for Linux).

## Inputs
- `aws_ami.ubuntu`: The ID of the AWS Machine Image(AMI) that is used for the EC2 instance. The script selects the most recent Ubuntu 20.04 image.
- `main_key`: A private key that is used to establish a SSH connection with the EC2 instance. It should be present in the same directory as the Terraform files.

## Outputs
- `public_ip`: The Public IP of the EC2 instance created.
- `DNS`: The Public DNS of the EC2 instance created.

## Steps to Run
1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Make sure you have your AWS credentials properly configured in your system.
4. Run the command `terraform init` to initialize the terraform in the current directory.
5. Run the command `terraform apply` to create the infrastructure. After running this command, Terraform will present an execution plan and will prompt for confirmation. Review the plan and if everything looks good, type `yes`.
6. Terraform will start building the infrastructure as per the code. This might take a few minutes.
7. After the successful creation of infrastructure, it will output the `public_ip` and `DNS` of the created EC2 instance.
8. You can browse `http://<public_ip>` or `http://<DNS>` to see the "Hello from Webserver" message.
