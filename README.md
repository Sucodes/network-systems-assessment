# Automated Deployment of a Dockerized Application on GCP using Terraform, Ansible, and GitHub Actions

## Overview

This project demonstrates an automated CI/CD workflow for deploying an application in a Docker container on Google Cloud Platform (GCP) virtual machine.

The automation is achieved using Terraform for infrastructure
provisioning, Ansible for server configuration and application deployment and GitHub Actions for continuous integration and deployment (CI/CD).

Whenever changes are pushed to the `app/` or `ansible/` directories, the workflow triggers an automatic update to the live server.

## Prerequisites

- A Google Cloud project with billing enabled

- Terraform

- An SSH key pair for CI (add the private key to GitHub Secrets)

## Quick start

Clone, configure, run:

```bash
git clone https://github.com/Sucodes/network-systems-assessment.git
cd network-systems-assessment
```

## 1. Provision infra with Terraform

```bash
cd terraform  
terraform init # run this after you create your own values like the machine type, subnet cidr, region etc
terraform apply
```

## 2. Add GitHub Secrets in your repo settings
- SSH_PRIVATE_KEY

- VM_HOST (the external IP of the VM)

- VM_USER 

## 3. Push to main, the CI job will SSH in and run Ansible to deploy your app.

## Conclusion

This project demonstrates a complete Infrastructure-as-Code pipeline integrating Terraform, Ansible, Docker and GitHub
Actions for an automated, repeatable, and efficient deployment workflow.
