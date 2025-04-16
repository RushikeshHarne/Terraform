# docker reuired in local machine
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx-server"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }
}
