#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal
# BLEAR Renewal Script - Script 1 of 2 - Renew Certs
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
RENEW_DAYS="45"
RENEW_HOOK_SCRIPT="./BLEAR_Hook.sh"
DOMAIN_TO_RENEW_CERT="louie.netel.isu.edu"


# Run Renew Within RENEW_DAYS of Expire and Run Hook Script On Success
/opt/lego/lego --email=$ADMIN_EMAIL --domains=$DOMAIN_TO_RENEW_CERT --path=$FULL_PATH --dns  bluecat renew --days $RENEW_DAYS --renew-hook=$RENEW_HOOK_SCRIPT
