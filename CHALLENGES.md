# Challenges
This document outlines the key technical challenges faced during the 8byte Intern DevOps assignment and the resolutions applied to ensure a smooth deployment of the Node.js application.

## 1. AWS Networking Setup
- **Issue:** Initial misconfiguration of route tables prevented EC2 from accessing the internet.
- **Resolution:** Associated route table correctly with the public subnet and attached Internet Gateway.

## 2. Security Group Rules
- **Issue:** Application was inaccessible due to missing inbound rule for port 3000.
- **Resolution:** Added explicit rule to allow TCP traffic on port 3000.

## 3. Docker Installation on EC2
- **Issue:** Docker service was not running after EC2 provisioning.
- **Resolution:** Verified installation via `systemctl status docker` and enabled service in `user_data`.

## 4. GitHub Actions Secrets
- **Issue:** Pipeline failed to push Docker image due to missing credentials.
- **Resolution:** Configured Docker Hub username/password as GitHub repository secrets.

## 5. Terraform State Management
- **Issue:** Accidentally re-created resources due to state mismatch.
- **Resolution:** Used `terraform refresh` and ensured `.tfstate` file was tracked properly.

## 6. Cost Awareness
- **Issue:** Risk of leaving EC2 running and incurring charges.
- **Resolution:** Destroyed infrastructure (`terraform destroy`) immediately after validation.

