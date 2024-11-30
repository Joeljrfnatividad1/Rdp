# Use a base image with a Linux distribution
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    software-properties-common \
    openjdk-11-jdk \
    tomcat9 \
    freerdp2-x11 \
    libfreerdp2-2 \
    gcc \
    make \
    libcairo2-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libtool-bin \
    libossp-uuid-dev \
    libssl-dev \
    libvorbis-dev \
    libwebp-dev \
    && apt-get clean

# Download and install Guacamole server
RUN wget https://downloads.apache.org/guacamole/1.5.0/source/guacamole-server-1.5.0.tar.gz && \
    tar -xzf guacamole-server-1.5.0.tar.gz && \
    cd guacamole-server-1.5.0 && \
    ./configure --with-init-dir=/etc/init.d && \
    make && \
    make install && \
    ldconfig

# Download and install Guacamole client
RUN mkdir -p /var/lib/tomcat9/webapps && \
    wget https://downloads.apache.org/guacamole/1.5.0/binary/guacamole-1.5.0.war -O /var/lib/tomcat9/webapps/guacamole.war

# Set up the configuration directory
RUN mkdir -p /etc/guacamole && \
    echo "guacd-hostname: localhost" > /etc/guacamole/guacamole.properties && \
    echo "guacd-port: 4822" >> /etc/guacamole/guacamole.properties

# Expose ports
EXPOSE 8080 4822

# Start services
CMD ["bash", "-c", "service tomcat9 start && guacd -f"]
