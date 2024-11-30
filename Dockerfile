# Use Ubuntu base image
FROM ubuntu:latest

# Install XRDP
RUN apt-get update && apt-get install -y xrdp

# Set RDP username and password
ENV RDP_USERNAME=root
ENV RDP_PASSWORD=root

# Expose RDP port
EXPOSE 3389

# Start XRDP service
CMD ["xrdp"]
