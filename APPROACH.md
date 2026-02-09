# Approach
This document explains the rationale behind the chosen infrastructure, tools, and deployment strategy for the 8byte Intern DevOps assignment. The approach emphasizes automation, reproducibility, and cost-efficient cloud deployment.

## Rationale for Chosen Infrastructure and Tools

### 1. Infrastructure as Code (Terraform)
- **Why Terraform?**
  - Declarative syntax for reproducible infrastructure.
  - Easy lifecycle management (`init`, `plan`, `apply`, `destroy`).
  - Cloud-agnostic but deeply integrated with AWS.

### 2. AWS Networking
- **Why AWS VPC + EC2?**
  - VPC provides secure, isolated networking.
  - Public subnet allows controlled internet access.
  - EC2 is a simple, cost-effective compute option for containerized apps.

### 3. Containerization (Docker)
- **Why Docker?**
  - Ensures consistent environment across local, CI, and cloud.
  - Simplifies deployment with portable images.
  - Easy integration with GitHub Actions.

### 4. CI/CD (GitHub Actions)
- **Why GitHub Actions?**
  - Native integration with GitHub repositories.
  - Automates build/test/deploy pipeline.
  - Pushes Docker images to Docker Hub for reuse.

### 5. Lifecycle & Cost Management
- Infrastructure destroyed after validation to avoid charges.
- Fully reproducible setup ensures quick redeployment when needed.

