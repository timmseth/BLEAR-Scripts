#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal Update Client
# BLEAR Update Client Script - Script 1 of 1 - Update Client
# Authors: Sam Jones, Seth Timmons


# Get Lego and Install in /opt/lego/
# Latest Lego release
LEGO_RELEASE=$(curl -s https://github.com/go-acme/lego/releases/latest | cut -d\" -f2 | cut -d\/ -f8)

# Download Lego release
wget https://github.com/go-acme/lego/releases/download/$LEGO_RELEASE/lego_"$LEGO_RELEASE"_linux_amd64.tar.gz -P /opt/lego/

# Untar the package
tar -xzvf /opt/lego/lego_"$LEGO_RELEASE"_linux_amd64.tar.gz -C /opt/lego/

# Show this version
/opt/lego/lego -v

