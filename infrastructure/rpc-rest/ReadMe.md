# RPC & REST (API) *WIP*

The Cosmos-SDK & Tendermint use a variety of methods to helps nodes communicate with each other.

More info can be found here: https://tutorials.cosmos.network/tutorials/1-tech-terms/

In this guide, we will turn a synced chain node into an RPC and/or REST (API) endpoint using Nginx and HTTPS certificates from Letsencrypt.

## Install and Prerequisites
Install Nginx.
```
sudo apt update
sudo apt install nginx -y
```

Assuming you're using UFW, you'll want to open up port 80 for certbot, and 443 for encrypted communication. This command will change your UFW automatically.
```
sudo ufw allow 'Nginx Full'
```

## Configure
Create Reverse Proxy using Nginx
```
cd $HOME
sudo rm /etc/nginx/sites-enabled/default
cd golden-nodes/infrastructure/templates/nginx

# RPC
sudo cp RPC-default /etc/nginx/sites-enabled
```

Edit configuration file by changing these variables `<example>`, please remove these symbols as well `<>`.
```
cd $HOME

# Edit RPC
sudo nano /etc/nginx/sites-enabled/RPC-default
```

## SSL Encryption for `https`
Install `certbot` and configure so that you can securely use `https` and forward all traffic there as well.
```
sudo apt install certbot python3-certbot-nginx -y
```

Get certificates. Replace `<>` with domain name.
```
sudo certbot --nginx -d <example>
```

Certbot will ask if you'd like to redirect all traffic from HTTP to HTTPS. 
Select yes (2). This will change the config slightly to forward traffic and to use SSL certificates.

# Auto Renewal
SSL certificates expire, luckily you certbot can auto renew, give it a test.
```
sudo certbot renew --dry-run
```
