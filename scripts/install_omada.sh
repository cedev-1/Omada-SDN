#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
OMADA_VERSION="5.14.26.1"
OMADA_DEB="Omada_SDN_Controller_v${OMADA_VERSION}_linux_x64.deb"
OMADA_URL="https://static.tp-link.com/upload/software/2024/202407/20240710/${OMADA_DEB}"
DATA_DIR="./data"
CONFIG_DIR="./config"

# Create necessary directories
mkdir -p ${DATA_DIR}
mkdir -p ${CONFIG_DIR}

# Download Omada Controller
echo "Downloading Omada SDN Controller version ${OMADA_VERSION}..."
wget -q "${OMADA_URL}" -O "/tmp/${OMADA_DEB}"

# Install Omada Controller
echo "Installing Omada SDN Controller..."
sudo gdebi -n "/tmp/${OMADA_DEB}"

# Cleanup
echo "Cleaning up..."
rm "/tmp/${OMADA_DEB}"

echo "Omada SDN Controller installed successfully."
