#!/bin/bash
# main_install.sh - Main script to install Ziti offline

echo "Starting offline Ziti installation..."

# ./configure_ufw.sh
# ./prepare_binaries.sh
./setup_environment.sh
# ./install_ziti.sh

source ./ziti-cli-functions.sh
expressInstall

# ./setup_ziti_services.sh

echo "Ziti has been installed and started successfully."