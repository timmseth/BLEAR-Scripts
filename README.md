# BLEAR-Scripts
# Bluecat Let's Encrypt Auto-Renewal (BLEAR)
# Authors: Sam Jones, Seth Timmons

These scripts install update create and renew Lets Encrypt certs using the LEGO client.

Each script will need to be configured for the domain, admin and Bluecat credentials.

The Hook script will need to be updated for the version of RHEL/Centos and Webserver that is being used.

1. create directory lego 

```mkdir /opt/lego```

2. change to directory

```cd /opt/lego```

3. clone the github repo 

```git clone https://github.com/jonesamu/BLEAR-Scripts.git```

4. Enter the BLEAR-Scripts directory

```cd /opt/lego/BLEAR-Scripts/```

5. Set all scripts to be Executable

```chmod a+x ./*```

6. Run Install Client
```./BLEAR_Install_Client```

7. Configure BLEARS_Create.sh to update BLUECAT_USER_NAME, BLUECAT_PASSWORD, ADMIN_EMAIL, and DOMAINS. Contents should look something like this:
```
#!/bin/bash
# Bluecat Let's Encrypt Auto-Renewal Creation
# BLEAR Creation Script - Script 1 of 1 - Create Certs
# Authors: Sam Jones, Seth Timmons

# Bluecat API Credentials Here
export BLUECAT_USER_NAME="<username>"
export BLUECAT_PASSWORD="<password>"

# Bluecat Organization Variables
export BLUECAT_SERVER_URL="http://cobalt.netel.isu.edu"
export BLUECAT_CONFIG_NAME="Idaho State University"
export BLUECAT_DNS_VIEW="default"


# Admin Variables
ADMIN_EMAIL="<admin email>"
FULL_PATH="/opt/lego/.lego/"

# Server Variables
DOMAINS="<site.domain.example.com>"


# Run and Register and create certs
/opt/lego/lego --email=$ADMIN_EMAIL --domains=$DOMAINS --path=$FULL_PATH --dns  bluecat run
```

8. Run BLEARS_Create.sh
```./BLEAR_Create.sh```

9.Modify BLEARS_Renew.sh to reflect cert locations accurately for your server.



#######################################################################################

