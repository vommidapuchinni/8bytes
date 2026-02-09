# 8byte Intern Assignment – DevOps Deployment Project

This project demonstrates an end-to-end DevOps workflow by deploying a containerized Node.js application on AWS infrastructure provisioned using Terraform and automated using GitHub Actions CI/CD.


The assignment showcases practical expertise in Infrastructure as Code, AWS cloud networking, containerization, CI/CD automation, and production-style deployment practices.

# Objectives

1. This project highlights hands-on experience in:
2. Infrastructure as Code using Terraform
3. AWS Networking (VPC architecture design)
4. Containerization using Docker
5. Continuous Integration using GitHub Actions
6. Application deployment on EC2 with public access
7. Infrastructure lifecycle and cost management

# Architecture Overview

![Architecture Diagram](screenshots/infrastructure.png)

The application is deployed inside a custom AWS Virtual Private Cloud (VPC) with secure internet connectivity and controlled access.

Component	Purpose
VPC	                  Custom isolated cloud network
Public                Subnet	Hosts the EC2 instance
Internet Gateway	    Enables internet connectivity
Route Table	          Routes outbound internet traffic
Security Group	      Allows SSH (22) and App access (3000)
EC2 Instance	       Hosts the Dockerized application
Docker	             Runs the Node.js application
GitHub Actions	     Automates Docker build (CI/CD pipeline)

### Run Application Locally
we have to install node, nodejs, terraform, docker, docker desktop locally
![NPM Install](screenshots/installations.png)
npm install && node app.js
![NPM Install](screenshots/npminstall.png)
Open in browser: http://localhost:3000
![Run Application Locally](screenshots/runsapplicationlocally.png)
Expected Output: 8byte Intern Assignment Successfully Deployed

# Dockerizing the Application
Dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]

## Build & Run
docker build -t 8byte-intern-app .
docker run -p 3000:3000 8byte-intern-app
![Docker Build Locally](screenshots/dockerbuildlocally.png)
![Docker Run Locally](screenshots/dockerrunlocally.png)
![Docker Container](screenshots/dockercontainer.png)
![Docker Image](screenshots/dockerimage.png)
![Access App Locally by Docker](screenshots/accessapplocallybydocker.png)
Visit: http://localhost:3000

# Infrastructure Provisioning with Terraform
Directory Structure
terraform/
provider.tf, variables.tf, terraform.tfvars, main.tf, outputs.tf

Purpose of Each File
File	                         Purpose
provider.tf	          Configures AWS provider (region: us-east-1)
variables.tf	        Defines reusable input variables
terraform.tfvars	    Stores environment-specific values
main.tf	Contains      infrastructure resources
outputs.tf	          Displays useful outputs (EC2 Public IP)

To create resources on AWS locally using Terraform, you need AWS credentials. These are obtained by creating an IAM user with programmatic access and generating an Access Key ID and Secret Access Key
![IAM User](screenshots/iamuser.png)
![Key Creation](screenshots/keycreation.png) 
![Access Keys](screenshots/accesskeys.png)

### Terraform Commands
terraform init
![Terraform Init](screenshots/terraforminit.png)
terraform plan
![Terraform Plan](screenshots/terraformplan.png)
terraform apply
![Terraform Apply](screenshots/terraformapply.png)
![Terraform Outputs](screenshots/terraformoutputs.png)
Resources Created: VPC, Public Subnet, Internet Gateway, Route Table & Association, Security Group (ports 22 and 3000), EC2 Instance (Ubuntu with Docker installed via user_data)

### Resources:
![EC2 Running](screenshots/EC2running.png)
![VPC](screenshots/vpc.png) 
![Public Subnet](screenshots/publicsubnet.png) 
![Internet Gateway](screenshots/igw.png) 
![Security Groups](screenshots/securitygrps.png)

# Push the code to github
create new git repository
![GitHub Repo Creation](screenshots/githubrepocreation.png)
Push code to github
![Push Code to GitHub](screenshots/pushcodetogithub.png)

# Deploy Application on EC2
ssh -i key.pem ubuntu@<EC2-PUBLIC-IP>
![SSH into EC2](screenshots/sshintoEC2.png)
check docker version and status by using the commands docker version && systemctl status docker
![Docker Status](screenshots/dockerstatus.png)
clone repo to EC2 from github
![Clone Repo to EC2](screenshots/clonerepotoEC2.png)
docker build -t app .
![Docker Build on EC2](screenshots/dockerbuildonEC2.png)
docker run -d -p 3000:3000 app
![Docker Run on EC2](screenshots/dockerrunonEC2.png)
Access in browser: http://<EC2-PUBLIC-IP>:3000
![Access App with Public IP](screenshots/accessappwithpublicip.png)

# GitHub Actions CI/CD
Workflow Location: .github/workflows/ci.yml
![Creation of CI YAML File](screenshots/creationofciyamlfile.png)
Pipeline Behavior
Triggered on push to the main branch.
![Workflow](screenshots/workflow.png)
I kept repo scretes that will login lo dockerhub by docker username and password
![Git Repo Secrets](screenshots/gitreposecrets.png)
Pipeline Steps:
1. Checkout repository
2. Set up Docker
3. Build Docker image
4. Verify successful build
5. Push image to Docker Hub
![Job Run Successful](screenshots/jobrunsuccessful.png)
![Docker Hub](screenshots/dockerhub.png)
![Image Push to Docker Hub](screenshots/imagepushtodockerhub.png)
This ensures every code change is automatically validated through CI.

# Infrastructure Lifecycle & Cost Management

The AWS infrastructure was provisioned using Terraform and the application deployment was successfully verified.

To follow responsible cloud usage practices and avoid unnecessary charges, the infrastructure was destroyed after validation: terraform destroy
![Terraform Destroy](screenshots/terrafromdestroy.png)
![Destroy Completed](screenshots/destroycompleted.png)

Since the setup is fully automated using Infrastructure as Code, the environment can be recreated at any time. I am prepared to redeploy the complete infrastructure live during evaluation if required.

# Final Outcome

This project demonstrates a production-style DevOps workflow including:
1. Cloud Infrastructure Provisioning
2. Secure AWS Networking
3. Dockerized Application Deployment
4. CI/CD Automation
5. Reproducible Infrastructure
