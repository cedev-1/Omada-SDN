# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jre-slim

# Set environment variables
ENV OMADA_VERSION=5.14.26.1
ENV OMADA_DEB=Omada_SDN_Controller_v${OMADA_VERSION}_linux_x64.deb
ENV OMADA_URL=https://static.tp-link.com/upload/software/2024/202407/20240710/${OMADA_DEB}

# dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    curl \
    mongodb-org \
    jsvc \
    gdebi-core \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q ${OMADA_URL} -O /tmp/${OMADA_DEB} \
    && gdebi -n /tmp/${OMADA_DEB} \
    && rm /tmp/${OMADA_DEB}

EXPOSE 8088 8043 27017

WORKDIR /opt/tplink/EAPController

COPY config/omada.properties /opt/tplink/EAPController/conf/

ENV JAVA_OPTS="-Xms512m -Xmx1024m"

CMD ["./start.sh"]
