
# BLEAR-Scripts
## Overview
**Project Title**: Bluecat Let's Encrypt Auto-Renewal (BLEAR)

**Contributors:** Sam Jones, Seth Timmons




## Description
These scripts install update create and renew Lets Encrypt certs using the LEGO client.

Each script will need to be configured for the domain, admin and Bluecat credentials.

The Hook script will need to be updated for the version of RHEL/Centos and Webserver that is being used.




## Install Instructions
##### 01. create directory lego 

```bash
mkdir /opt/lego
```

##### 02. change to directory

```bash
cd /opt/lego
```

##### 03. clone the github repo 

```bash
git clone https://github.com/jonesamu/BLEAR-Scripts.git
```

##### 04. Enter the BLEAR-Scripts directory
```bash
cd /opt/lego/BLEAR-Scripts/
```

##### 05. Set all scripts to be Executable
```bash
chmod a+x ./BLEAR*
```

##### 06. Run Install Client
```bash
./BLEAR_Install_Client
```

##### 07. Modify BLEAR_Create.sh 
```bash
vim ./BLEAR_Create.sh
```

This step is primarily to update: 
BLUECAT_USER_NAME, BLUECAT_PASSWORD, ADMIN_EMAIL, and DOMAINS.

Contents should look something like this:
```bash
#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal Creation
# BLEAR Creation Script - Script 1 of 1 - Create Certs
# Authors: Sam Jones, Seth Timmons

# Bluecat API Credentials Here
export BLUECAT_USER_NAME="<API username>"
export BLUECAT_PASSWORD="<API password>"

# Bluecat Organization Variables
export BLUECAT_SERVER_URL="<bluecat.ipam.url.com>"
export BLUECAT_CONFIG_NAME="<Your Organization>"
export BLUECAT_DNS_VIEW="default"


# Admin Variables
ADMIN_EMAIL="<admin email>"
FULL_PATH="/opt/lego/.lego/"

# Server Variables
DOMAINS="<full.domain.name.com>"


# Run and Register and create certs
/opt/lego/lego --email=$ADMIN_EMAIL --domains=$DOMAINS --path=$FULL_PATH --dns  bluecat run
```

##### 08. Run BLEAR_Create.sh
```bash
./BLEAR_Create.sh
```

##### 09. On Apache, modify your /etc/httpd/conf.d/ssl.conf to reflect the full path to cert and key files. 
```bash
vim /etc/httpd/conf.d/ssl.conf
```

The files should be full.domain.name.crt and full.domain.name.key like so:
```bash
#   Server Certificate:
# Point SSLCertificateFile at a PEM encoded certificate.  If
# the certificate is encrypted, then you will be prompted for a
# pass phrase.  Note that a kill -HUP will prompt again.  A new
# certificate can be generated using the genkey(1) command.
SSLCertificateFile /full/path/to/full.domain.name.com.crt

#   Server Private Key:
#   If the key is not combined with the certificate, use this
#   directive to point at the key file.  Keep in mind that if
#   you've both a RSA and a DSA private key you can configure
#   both in parallel (to also allow the use of DSA ciphers, etc.)
SSLCertificateKeyFile /full/path/to/full.domain.name.com.key

```

##### 10. Modify BLEAR_Renew.sh
```bash
vim ./BLEAR_Renew.sh
```

This step is primarily to update: 
BLUECAT_USER_NAME, BLUECAT_PASSWORD, ADMIN_EMAIL, and DOMAIN_TO_RENEW_CERT.

Contents should look something like this:
```bash
#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal
# BLEAR Renewal Script - Script 1 of 2 - Renew Certs
# Authors: Sam Jones, Seth Timmons

# Bluecat API Credentials Here
export BLUECAT_USER_NAME="<API username>"
export BLUECAT_PASSWORD="<API password>"

# Bluecat Organization Variables
export BLUECAT_SERVER_URL="<bluecat.ipam.url.com>"
export BLUECAT_CONFIG_NAME="<Your Organization>"
export BLUECAT_DNS_VIEW="default"

# Admin Variables
ADMIN_EMAIL="<admin@email.com>"
FULL_PATH="/opt/lego/.lego/"

# Server Variables
RENEW_DAYS="45"
RENEW_HOOK_SCRIPT="./BLEAR_Hook.sh"
DOMAIN_TO_RENEW_CERT="<full.domain.name.com>"

# Run Renew Within RENEW_DAYS of Expire and Run Hook Script On Success
/opt/lego/lego --email=$ADMIN_EMAIL --domains=$DOMAIN_TO_RENEW_CERT --path=$FULL_PATH --dns  bluecat renew --days $RENEW_DAYS --renew-hook=$RENEW_HOOK_SCRIPT
```

##### 11. Modify BLEAR_Hook.sh
```bash
vim ./BLEAR_Hook.sh
```

This step is primarily to update:
CERT_NAME, FULL_PATH_NEW_CERT, SERVER_CERT_STORE, and SERVER_KEY_STORE.

Contents should look something like this:
```bash
#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal
# BLEAR Hook Script - Script 2 of 2 - Move Certificates
# Authors: Sam Jones, Seth Timmons

# New Cert Domain
CERT_NAME="<full.domain.name.com>"

# Cert Paths
FULL_PATH_NEW_CERT="/opt/lego/.lego/certificates/"
SERVER_CERT_STORE="/etc/httpd/certstuff/"
SERVER_KEY_STORE="/etc/httpd/certstuff/"

# Move the cert
cp $FULL_PATH_NEW_CERT$CERT_NAME.key $SERVER_KEY_STORE
cp $FULL_PATH_NEW_CERT$CERT_NAME.crt $SERVER_CERT_STORE

# Restart the webserver
service httpd restart
```

##### 12. Run BLEAR_Hook.sh
```bash
./BLEAR_Hook.sh
```

##### 13. Copy the CRON script from BLEAR.cron to /etc/cron.d/

```bash
cp ./BLEAR.cron /etc/cron.d/
```
