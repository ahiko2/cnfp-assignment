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
