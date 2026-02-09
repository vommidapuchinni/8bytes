# 8byte Intern Assignment – DevOps Deployment Project

## Table of Contents
- [Objectives](#objectives)
- [Architecture Overview](#architecture-overview)
- [Run Application Locally](#run-application-locally)
- [Dockerizing the Application](#dockerizing-the-application)
- [Infrastructure Provisioning with Terraform](#infrastructure-provisioning-with-terraform)
- [Deploy Application on EC2](#deploy-application-on-ec2)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Infrastructure Lifecycle & Cost Management](#infrastructure-lifecycle--cost-management)
- [Final Outcome](#final-outcome)

## Prerequisites

Before running this project locally or provisioning infrastructure, ensure you have:

- Node.js & npm
- Docker & Docker Desktop
- Terraform
- AWS Account with IAM user credentials (Access Key ID & Secret Access Key)


## Objectives

This project demonstrates hands-on experience in:

1. Infrastructure as Code using Terraform
2. AWS Networking (VPC architecture design)
3. Containerization using Docker
4. Continuous Integration using GitHub Actions
5. Application deployment on EC2 with public access
6. Infrastructure lifecycle and cost management


## Architecture Overview

![Architecture Diagram](infrastructure.png)

| Component       | Purpose                              |
|-----------------|--------------------------------------|
| VPC             | Custom isolated cloud network        |
| Public Subnet   | Hosts the EC2 instance               |
| Internet Gateway| Enables internet connectivity        |
| Route Table     | Routes outbound internet traffic     |
| Security Group  | Allows SSH (22) & App (3000)        |
| EC2 Instance    | Hosts the Dockerized application     |
| Docker          | Runs the Node.js application         |
| GitHub Actions  | Automates Docker build (CI/CD)       |

## Run Application Locally

Before deploying to AWS, you can test and run the Node.js application on your local machine to ensure it works as expected.

Install dependencies and run the application:

```bash
npm install
node app.js
```
Installations
![NPM Install](screenshots/installations.png)
npm install && node app.js
![NPM Install](screenshots/npminstall.png)
Open in browser: http://localhost:3000
![Run Application Locally](screenshots/runsapplicationlocally.png)
Expected Output: 8byte Intern Assignment Successfully Deployed

## Dockerizing the Application

We will now containerize the Node.js app using Docker to prepare it for deployment on EC2.

```Dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]
```

## Build & Run
docker build -t 8byte-intern-app . # build docker file

docker run -p 3000:3000 8byte-intern-app

Docker build locally
![Docker Build Locally](screenshots/dockerbuildlocally.png)
Docker run locally
![Docker Run Locally](screenshots/dockerrunlocally.png)
Docker container
![Docker Container](screenshots/dockercontainer.png)
Docker image
![Docker Image](screenshots/dockerimage.png)
Access APP
![Access App Locally by Docker](screenshots/accessapplocallybydocker.png)
Visit: http://localhost:3000

## Infrastructure Provisioning with Terraform

Terraform allows us to define and provision AWS infrastructure in code, making deployments repeatable and manageable.

Directory Structure
terraform/
provider.tf, variables.tf, terraform.tfvars, main.tf, outputs.tf

Purpose of Each File
| File            | Purpose                                    |
|-----------------|--------------------------------------------|
| provider.tf     | Configures AWS provider (region: us-east-1)|
| variables.tf    |Defines reusable input variables            |
| Internet Gateway| Stores environment-specific values         |
| main.tf	Contains| infrastructure resources                   |
| outputs.tf      |  Displays useful outputs (EC2 Public IP)   |


To create resources on AWS locally using Terraform, you must provide AWS credentials. These credentials are obtained by creating an IAM user with programmatic access and generating an Access Key ID and Secret Access Key. Terraform uses these keys to authenticate and provision AWS resources.

IAM User
![IAM User](screenshots/iamuser.png)
Secret keys creation for credentials
![Key Creation](screenshots/keycreation.png) 
Access and secret keys
![Access Keys](screenshots/accesskeys.png)

### Terraform Commands
**terraform init**
![Terraform Init](screenshots/terraforminit.png)
**terraform plan**
![Terraform Plan](screenshots/terraformplan.png)
**terraform apply**
![Terraform Apply](screenshots/terraformapply.png)
outputs
![Terraform Outputs](screenshots/terraformoutputs.png)

Resources Created: VPC, Public Subnet, Internet Gateway, Route Table & Association, Security Group (ports 22 and 3000), EC2 Instance (Ubuntu with Docker installed via user_data)

### Resources:
EC2 running
![EC2 Running](screenshots/EC2running.png)
VPC
![VPC](screenshots/vpc.png) 
Subnet
![Public Subnet](screenshots/publicsubnet.png) 
Internet gateway
![Internet Gateway](screenshots/igw.png) 
Security groups
![Security Groups](screenshots/securitygrps.png)
Route table and subnet association also done but that screenshot was missed

## Push the code to github
create new git repository
![GitHub Repo Creation](screenshots/githubrepocreation.png)
Push code to github
![Push Code to GitHub](screenshots/pushcodetogithub.png)

## Deploy Application on EC2
Once the infrastructure is ready, we deploy the Dockerized Node.js application to the EC2 instance and verify it works in the cloud environment.

ssh -i key.pem ubuntu@EC2-PUBLIC-IP

SSH into EC2
![SSH into EC2](screenshots/sshintoEC2.png)
check docker version and status by using the commands docker version && systemctl status docker

Docker status
![Docker Status](screenshots/dockerstatus.png)
clone repo to EC2 from github
![Clone Repo to EC2](screenshots/clonerepotoEC2.png)
docker build -t app .

Docker build on EC2
![Docker Build on EC2](screenshots/dockerbuildonEC2.png)
docker run -d -p 3000:3000 app

Docker run on EC2
![Docker Run on EC2](screenshots/dockerrunonEC2.png)
Access in browser: http://<EC2-PUBLIC-IP>:3000

Access app
![Access App with Public IP](screenshots/accessappwithpublicip.png)

## GitHub Actions CI/CD
We will automate building, testing, and optionally pushing the Docker image using GitHub Actions to implement a full CI/CD pipeline.

Workflow Location: .github/workflows/ci.yml

Creation of workflow files and push to github
![Creation of CI YAML File](screenshots/creationofciyamlfile.png)
Pipeline Behavior

Triggered on push to the main branch.

![Workflow](screenshots/workflow.png)
repo secrets to login to Docker Hub
![Git Repo Secrets](screenshots/gitreposecrets.png)
Pipeline Steps:
1. Checkout repository
2. Set up Docker
3. Build Docker image
4. Verify successful build
5. Push image to Docker Hub

Workflow Successfully ran
![Job Run Successful](screenshots/jobrunsuccessful.png)
Docker Hub
![Docker Hub](screenshots/dockerhub.png)
Image pushed to docker hub
![Image Push to Docker Hub](screenshots/imagepushtodockerhub.png)
This ensures every code change is automatically validated through CI.
![Triggering](screenshots/triggering.png)

## Infrastructure Lifecycle & Cost Management

After successfully deploying and verifying the application on AWS, it is important to manage resources efficiently and avoid unnecessary costs.

The AWS infrastructure was provisioned using Terraform and the application deployment was successfully verified.

To follow responsible cloud usage practices and minimize charges, the infrastructure was destroyed after validation using: terraform destroy

![Terraform Destroy](screenshots/terrafromdestroy.png)
![Destroy Completed](screenshots/destroycompleted.png)

Since the setup is fully automated with Infrastructure as Code, the environment can be recreated at any time. I am prepared to redeploy the complete infrastructure live during evaluation if required.

## Final Outcome

This project demonstrates a production-style DevOps workflow that covers the full lifecycle from setup to automation, including:

1. Cloud Infrastructure Provisioning
2. Secure AWS Networking
3. Dockerized Application Deployment
4. CI/CD Automation
5. Reproducible Infrastructure
