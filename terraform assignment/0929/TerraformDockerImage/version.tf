terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "mkcustomnginx" {
  name = "minkhint23/mksithu-custom-nginx:hellocloud-assignment"
  keep_locally = false
}

# Create a container with port mapping
resource "docker_container" "foo" {
  name  = "foo"
  image = docker_image.mkcustomnginx.name

  ports {
    internal = 1918
    external = 8080
  }
}

