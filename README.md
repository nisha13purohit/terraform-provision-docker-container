Terraform + Docker: Provisioning a Local Container (IaC)

Infrastructure as Code (IaC) project that uses Terraform and its Docker provider to create an Nginx container on a local machine, with no manual docker run commands.

Tech Stack
Terraform
Docker (Docker Desktop / Engine)
Git & GitHub
Project Structure
task-3-terraform-docker/
├── main.tf        # Terraform configuration (provider, image, container, output)
├── .gitignore     # Keeps state files and .terraform/ out of Git
├── logs/          # Execution logs (init, plan, apply, state, destroy)
└── README.md
What main.tf Does
Block	Purpose
terraform { required_providers }	Downloads the kreuzwerker/docker provider
provider "docker"	Connects Terraform to the local Docker daemon
docker_image.nginx	Pulls the nginx:latest image
docker_container.nginx	Runs a container named terraform-nginx, mapping host port 8080 to container port 80
output.container_url	Prints the URL to open
Prerequisites
Terraform installed: terraform -version
Docker running: docker ps
How to Run
bash
terraform init       # download provider
terraform init 2>&1 | tee logs/init.log

terraform validate   # check syntax

terraform plan       # preview changes
terraform plan 2>&1 | tee logs/plan.log

terraform apply      # create container (type yes)
terraform apply -auto-approve 2>&1 | tee logs/apply.log

Open http://localhost:8080 to see the Nginx welcome page.

Inspect:

bash
docker ps

terraform state list
terraform state list 2>&1 | tee logs/state.log

terraform state show docker_container.nginx
terraform state show docker_container.nginx 2>&1 | tee -a logs/state.log

Clean up:

bash
terraform destroy    # type yes
terraform destroy -auto-approve 2>&1 | tee logs/destroy.log

docker ps -a
Windows Note

If you see a Docker connection error, uncomment this line in the provider block:

hcl
host = "npipe:////./pipe/docker_engine"
Execution Logs

Saved in the logs/ folder: init.log, plan.log, apply.log, state.log, destroy.log.

Key Learnings
Terraform is declarative: you describe the end state, Terraform works out the steps.
plan previews changes before apply makes them.
The state file tracks what Terraform manages.
destroy removes everything it created.
Author

Nisha Purohit