# Omada SDN Controller Docker Setup

A Dockerized installation of the TP-Link Omada SDN Controller, facilitating easy deployment and management.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Using Docker Compose](#using-docker-compose)
  - [Using Docker CLI](#using-docker-cli)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Omada SDN Controller allows you to manage your TP-Link network devices centrally. This project containerizes the Omada Controller, making it easy to deploy on any system with Docker installed.

## Features

- **Easy Deployment:** Quickly set up the Omada Controller using Docker.
- **Persistent Storage:** Data is stored persistently on your host.
- **Custom Configuration:** Easily customize settings via configuration files.
- **Automated Updates:** Simplify updating the controller by rebuilding the Docker image.

## Prerequisites

- **Docker:** Ensure Docker is installed on your system. [Installation Guide](https://docs.docker.com/get-docker/)
- **Docker Compose:** Recommended for managing multi-container applications. [Installation Guide](https://docs.docker.com/compose/install/)
- **Sudo Privileges:** Required for installing dependencies and managing Docker.

## Installation

### Using Docker Compose

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/cedev-1/omada-docker.git
   cd omada-docker

2. **Run Docker compose:**

   ```bash
   docker-compose up -d
   ```
This will download the necessary images, build the container, and start the Omada Controller.

3. Access the Omada Controller Web Interface:

   After running the container, you can access the Omada Controller's web interface at:
   - HTTP: http://localhost:8088
   - HTTPS: https://localhost:8043

### Using Docker CLI

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/cedev-1/omada-docker.git
   cd omada-docker
   ```

2. **Build the Docker Image:**

   ```bash
   docker build -t omada-controller .
   ```

3. **Run the Docker Image:**

   ```bash
    docker run -d --name omada-controller \
    -p 8088:8088 \
    -p 8043:8043 \
    -v $(pwd)/data:/opt/tplink/EAPController/data \
    -v $(pwd)/config:/opt/tplink/EAPController/conf \
    omada-controller
   ```

This will build and run the container, making the Omada Controller accessible at the same URLs as with Docker Compose.

## Configuration

The Omada Controller's configuration can be customized through the config/omada.properties file in the repository. This allows you to change ports, data directories, and other settings.
Example Configuration (config/omada.properties):

    '''bash
    # HTTP Port
    http.port=8088

    # HTTPS Port
    https.port=8043

    # MongoDB Configuration
    mongodb.host=localhost
    mongodb.port=27017
    mongodb.username=omada
    mongodb.password=omada-password

    # Data Directory
    data.dir=/opt/tplink/EAPController/data

    # Java Options
    JAVA_OPTS=-Xms512m -Xmx1024m
    '''

Edit this file as needed before starting the container.

## Usage


Starting the container 
- Using Docker Compose:

  ```bash
  docker-compose start
  ```
- Using Docker CLI:

  ```bash
  docker start omada-controller
  ``` 


Stopping the container 
- Using Docker Compose:

  ```bash
  docker-compose stop
  ```
- Using Docker CLI:

  ```bash
  docker stop omada-controller
  ```


Rebuilding the container 
- Using Docker Compose:

  ```bash
  docker-compose build
  ```
- Using Docker CLI:

  ```bash
  docker build -t omada-controller .
  ```


# Troubleshooting
- Ports are already in use: Make sure ports 8088 and 8043 are not being used by other services on your system.
- Data not persistent: Ensure the volumes are correctly mounted. The data directory should persist even after stopping the container.
- Controller won't start: Check the logs for detailed error messages:

  ```bash
  docker logs omada-controller
  ```


# License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.   
