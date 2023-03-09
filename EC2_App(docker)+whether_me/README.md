# Terraform Infrastructure as Code
This Terraform code provisions a basic AWS infrastructure including a VPC, internet gateway, subnet, security groups, and EC2 instances. The instances are configured with Docker, and the user data includes a script that pulls a Docker image from an AWS ECR repository and runs it.

# Prerequisites and Requirements
private key in my case <code>main_key.pem</code><br><code>go get -u github.com/gin-gonic/gin</code>
and
<ul>
  <li>An AWS account with appropriate permissions</li>
  <li>The AWS CLI installed and configured with credentials for the account</li>
  <li>Terraform installed on your local machine</li>
  <li>Docker image and associated ECR repository</li>
</ul>

# What does it do 
deploy app using docker


# The app
port:<code>8080</code>
be sure to use the ip given + port
# issue 
docker provide is broken

# References
https://github.com/e2eSolutionArchitect/scripts/blob/main/docker/install-docker-ubuntu.md <br>
https://www.terraform.io/<br>
https://aws.amazon.com/<br>
https://www.docker.com/<br>
https://aws.amazon.com/ecr/<br>

# OpenWeatherMap Web App
This is a simple web application that uses the OpenWeatherMap API to display weather information for a given city. The user can either search for a specific city or generate a random city to display weather information for.

# Technologies Used
The application is built using Go and the Gin web framework. It uses the following third-party packages:

<ul>
  <li>go-randomdata: to generate random city names
</li>
  <li>The AWS CLI installed and configured with credentials for the account</li>
  <li>gjson: to parse JSON responses from the OpenWeatherMap API</li>
  <li>gin-contrib/static: to serve static files (e.g. CSS, images)</li>
</ul>


# Routes
The application has the following routes:

GET /: Displays the home page.<br>
GET /Search: Displays the search page.<br>
POST /Results: Displays the weather information for the searched or randomly generated city.<br>


