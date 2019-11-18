#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal
# BLEAR Hook Script - Script 2 of 2 - Move Certificates
# Authors: Sam Jones, Seth Timmons

# New Cert Domain
CERT_NAME="louie.netel.isu.edu"

# Cert Paths
FULL_PATH_NEW_CERT="/opt/lego/.lego/certificates/"
SERVER_CERT_STORE="/etc/pki/tls/certs/"
SERVER_KEY_STORE="/etc/pki/tls/private/"

# Move the cert
cp $FULL_PATH_NEW_CERT$CERT_NAME.key $SERVER_KEY_STORE
cp $FULL_PATH_NEW_CERT$CERT_NAME.crt $SERVER_CERT_STORE

# Restart the webserver
service httpd restart
# systemctl restart httpd

