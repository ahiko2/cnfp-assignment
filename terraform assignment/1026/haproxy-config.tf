resource "local_file" "haproxy_cfg" {
    content = <<-EOT
    global
            stats socket /var/run/api.sock user haproxy group haproxy mode 660 level admin expose-fd listeners
            log stdout format raw local0 info

    defaults
            mode http
            timeout client 10s
            timeout connect 5s
            timeout server 10s
            timeout http-request 10s
            log global

    frontend stats
            bind *:8404
            stats enable
            stats uri /
            stats refresh 10s

    frontend myfrontend
            bind *:443 ssl crt /usr/local/etc/haproxy/haproxy.pem
            default_backend webservers

    backend webservers
            server nginx1 ngweb1:443 check
            server nginx2 ngweb2:443 check
            server nginx3 ngweb3:443 check
    EOT
    filename = "${path.module}/haproxy/haproxy.cfg"
}