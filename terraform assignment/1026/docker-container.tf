## Docker container nginx

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
resource "docker_network" "mynetwork" {
  name   = "mynetwork"
  driver = "bridge"
}

# Reference the local image
resource "docker_image" "mkcustomnginx" {
  name         = "custom_nginx_sithu:hellocloud"
  keep_locally = true
}

# Create a container with port mapping
resource "docker_container" "nginx1" {
  name         = "ngweb1"
  image        = docker_image.mkcustomnginx.name
  networks_advanced {
    name = docker_network.mynetwork.name
  }

  ports {
    internal = 443
    external = 6443
  }
}

# Create a container with port mapping
resource "docker_container" "nginx2" {
  name         = "ngweb2"
  image        = docker_image.mkcustomnginx.name
  networks_advanced {
    name = docker_network.mynetwork.name
  }
  ports {
    internal = 443
    external = 6444
  }
}

# Create a container with port mapping
resource "docker_container" "nginx3" {
  name         = "ngweb3"
  image        = docker_image.mkcustomnginx.name
  networks_advanced {
    name = docker_network.mynetwork.name
  }

  ports {
    internal = 443
    external = 6445
  }
}

# Create HAProxy container with port mapping
resource "docker_container" "haproxy" {
  name         = "haproxy"
  image        = "haproxytech/haproxy-alpine:2.4"
  networks_advanced {
    name = docker_network.mynetwork.name
  }

  volumes {
    host_path      = "${abspath(path.module)}/HAproxy"
    container_path = "/usr/local/etc/haproxy"
    read_only      = true
  }

  ports {
    internal = 443
    external = 8443
  }

  ports {
    internal = 8404
    external = 8404
  }
}

# Create second HAProxy container with port mapping
resource "docker_container" "haproxy2" {
  name         = "haproxy2"
  image        = "haproxytech/haproxy-alpine:2.4"
  networks_advanced {
    name = docker_network.mynetwork.name
  }

  volumes {
    host_path      = "${abspath(path.module)}/HAproxy"
    container_path = "/usr/local/etc/haproxy"
    read_only      = true
  }

  ports {
    internal = 443
    external = 8444
  }

  ports {
    internal = 8404
    external = 8405
  }
}

# checking network
## docker network ls
## docker inspect mynetwork

# checking container network
## docker inspect nginx1
## docker inspect nginx2
## docker inspect nginx3

#------------------------------------------------------------------------------------------------------------------------

###Generate cert for use in haproxy###
# cd haproxy
# openssl req -new -x509 -days 365 -nodes -newkey rsa:2048 -keyout haproxy.key -out haproxy.crt -subj "/CN=localhost1"
# cat haproxy.crt | openssl x509 --noout --text 
# cd ..
# bash -c 'cat haproxy.crt haproxy.key >> haproxy.pem'