# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to avoid some interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package repository and install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy the website code to the Apache root directory
COPY . /var/www/html/

# Expose port 80 to allow access to the web server
EXPOSE 82

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
