# ---------------------------------------------------------
# Task 3: IaC with Terraform - provision a local Docker container
# ---------------------------------------------------------

# 1. Tell Terraform which provider (plugin) to download

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# 2. Configure the Docker provider
#    Linux/Mac: default works (unix:///var/run/docker.sock)
#    Windows (Docker Desktop): uncomment the host line below

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# 3. Resource: pull the nginx image

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false # remove image on destroy
}

# 4. Resource: create the container from that image

resource "docker_container" "nginx" {
  name  = "terraform-nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}

# 5. Output: print the URL after apply

output "container_url" {
  value = "http://localhost:8080"
}