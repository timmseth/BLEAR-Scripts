#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal Creation
# BLEAR Creation Script - Script 1 of 1 - Create Certs
# Authors: Sam Jones, Seth Timmons

# Bluecat API Credentials Here
export BLUECAT_USER_NAME=""
export BLUECAT_PASSWORD=""

# Bluecat Organization Variables
export BLUECAT_SERVER_URL="http://cobalt.netel.isu.edu"
export BLUECAT_CONFIG_NAME="Idaho State University"
export BLUECAT_DNS_VIEW="default"


# Admin Variables
ADMIN_EMAIL="admin@email.com"
FULL_PATH="/opt/lego/.lego/"

# Server Variables
DOMAINS="louie.netel.isu.edu"


# Run and Register and create certs
/opt/lego/lego --email=$ADMIN_EMAIL --domains=$DOMAINS --path=$FULL_PATH --dns  bluecat run


