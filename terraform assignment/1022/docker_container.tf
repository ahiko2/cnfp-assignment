provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "mkcustomnginx" {
  name = "minkhint23/custom_nginx_sithu:hellocloud"
  keep_locally = false
}

# Create a container with port mapping
resource "docker_container" "boo" {
  name  = "boo"
  image = docker_image.mkcustomnginx.name

  ports {
    internal = 1918
    external = 8080
  }
}

