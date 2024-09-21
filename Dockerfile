# Use the base image
FROM openjdk:8-jre-slim

# Set environment variables
ENV OMADA_VERSION=5.14.26.1
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    curl \
    jsvc \
    gdebi-core \
    procps && \
    rm -rf /var/lib/apt/lists/*

# Create the 'omada' user and group
RUN useradd -r -d /opt/tplink/EAPController -s /bin/false omada

# Download and install Omada Controller
RUN wget https://static.tp-link.com/upload/software/2024/202407/20240710/Omada_SDN_Controller_v${OMADA_VERSION}_linux_x64.deb && \
    gdebi -n Omada_SDN_Controller_v${OMADA_VERSION}_linux_x64.deb && \
    rm Omada_SDN_Controller_v${OMADA_VERSION}_linux_x64.deb

# Expose required ports
EXPOSE 8088 8043 27017

# Define entrypoint
ENTRYPOINT ["jsvc"]
CMD ["-cwd", "/opt/tplink/EAPController", "-user", "omada", "-outfile", "logs/console.log", "-pidfile", "logs/omada.pid", "-Djava.awt.headless=true", "-Xms128M", "-Xmx1024M", "-Djava.util.logging.config.file=properties/log4j.properties", "-cp", "libs/*", "com.tplink.omada.start.OmadaMain"]
