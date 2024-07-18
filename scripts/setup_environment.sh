#!/bin/bash
# setup_environment.sh - Script to set up environment variables and copy configuration files

echo "Setting up environment variables..."
source ../config/ziti.env

# echo "Copying configuration files..."
# cp ../config/controller.yaml /etc/ziti/controller.yaml
# cp ../config/edge-router.yaml /etc/ziti/edge-router.yaml

echo "Environment setup completed."
