# Terraform Infrastructure with Golang Application

## 1. Title
Deploying a GoLang Application on AWS EC2 using Terraform and Bash Scripting

## 2. Background
The purpose of this project is to demonstrate how to automatically provision and deploy an AWS EC2 instance using Terraform and Bash scripting. The instance will have a GoLang application cloned from a GitHub repository, which will be built and run on the EC2 instance.

## 3. Prerequisites
Before you can use this project, make sure you have the following set up:

- An AWS Account with appropriate permissions to create resources
- Terraform installed on your local machine (version 0.13 or newer)
- AWS CLI configured with your credentials
- An SSH key pair named "main_key" created in the AWS region you're going to use

## 4. Inputs
There are no specific inputs required, all the configurations such as VPC, subnet, security groups, and EC2 instance details are already set within the Terraform file. You only need to ensure your AWS CLI is configured properly on your local machine.

## 5. Outputs
The Terraform script will output the following information:

- Public IP Address of the EC2 instance
- Public DNS of the EC2 instance

## 6. Steps to Run
Follow the steps below to deploy the GoLang application:

1. Clone this repository to your local machine.
2. Navigate to the directory containing the Terraform file and user_data.sh.
3. Run `terraform init` to initialize the Terraform working directory.
4. Run `terraform validate` to confirm the Terraform file is configured correctly.
5. Run `terraform plan` to create an execution plan and see what resources Terraform will create.
6. Run `terraform apply` to create the resources. Type `yes` when prompted to confirm the creation of the resources.
7. After the script has finished executing, the public IP and DNS of the EC2 instance will be displayed. You can use these to access the running GoLang application.
8. To clean up the resources after you're done, run `terraform destroy` and type `yes` when prompted.

_Note: Be sure to run `terraform destroy` when you're done to avoid unnecessary AWS charges._




# What does it do 
deploy app using git clone

# what does it clone?
<code>https://github.com/Khald1998/Clone.git</code> <br>

# Requirements
private key in my case <code>main_key.pem</code>

# The app
<a>https://github.com/Khald1998/Clone</a>
port:<code>8080</code>




