resource "local_file" "index_html" {
    filename = "${path.module}/html/index.html"
    content  = <<-EOF
    <html>
        <head>
            <title>Nginx title</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                h1 {
                    color: #333;
                }
                .container {
                    text-align: center;
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Hello, Cloud Native!</h1>
            </div>
        </body>
    </html>
    EOF
    
}
resource "local_file" "nginx_conf" {
    content  = <<-EOF
        events {
            worker_connections 1024;
        }
        http {
            server {
                listen       1918;
                server_name  localhost;
                location / {
                    root   /usr/share/nginx/html;
                    index  index.html index.htm;
                }
                error_page   500 502 503 504  /50x.html;
                location = /50x.html {
                    root   /usr/share/nginx/html;
                }
            }
        }
    EOF
    filename = "${path.module}/nginx.conf"
}

resource "local_file" "dockerfile" {
    filename = "${path.module}/Dockerfile"
    content  = <<-EOT
    # Use the official NGINX base image
    FROM nginx:latest

    # Copy the custom NGINX configuration file
    COPY nginx.conf /etc/nginx/nginx.conf

    # Copy your static website files (optional)
    COPY html /usr/share/nginx/html

    # Expose the desired port
    EXPOSE 1918

    # Start NGINX
    CMD ["nginx", "-g", "daemon off;"]
    EOT
}
resource "docker_image" "nginx_image" {
    name         = "custom_nginx_sithu:hellocloud"
    build {
        context    = "${path.module}"
        dockerfile = "${path.module}/Dockerfile"
    }
}