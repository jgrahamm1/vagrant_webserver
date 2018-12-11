#!/usr/bin/env bash


### Getting IP ###
new_ip=$(ip address show eth1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//')
echo $new_ip > ip_addr

### Setting up webserver ###
# Install apache
apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Generate SSL Certificates
cd /home/vagrant
openssl genrsa -out $new_ip.key 2048
openssl req -new -x509 -key $new_ip.key -out $new_ip.cert -days 3650 -subj /CN=$new_ip

# Replace apache and index files
mkdir -p /var/www/html
cp /home/vagrant/000-default.conf /etc/apache2/sites-enabled/000-default.conf
cp /home/vagrant/index.php /var/www/html/index.php
sed -i -e "s/192.168.50.5/$new_ip/g" /etc/apache2/sites-enabled/000-default.conf

# Enable SSL and restart webserver
sudo a2enmod ssl
sudo service apache2 restart


### Git Server ###
sudo apt-get install -y git-core

# Git user
sudo useradd -g admin -m -p saEB/i2Fr65Mo -s /bin/bash admin

sudo -u admin mkdir -p /home/admin/.ssh
sudo -u admin touch /home/admin/.ssh/authorized_keys
sudo -u admin chmod 600 /home/admin/.ssh/authorized_keys
sudo -u admin mkdir -p /home/admin/admin.git

# Making git repo
cd /home/admin/admin.git
sudo -u admin git init --bare
sudo -u admin chmod 775 /home/admin/admin.git
sudo chmod -R a+rwX /home/admin/admin.git/*

### PHP ###
su
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
sudo service apache2 restart


# Allow git pull
mkdir -p /home/www-data
chown www-data:www-data /home/www-data
mkdir -p /home/www-data/.ssh
chown www-data:www-data /home/www-data/.ssh
chmod 0700 /home/www-data/.ssh

# Creating home directory for www-data
sudo sed -i '/www-data*/d' /etc/passwd
sudo echo "www-data:x:33:33:www-data:/home/www-data:/usr/sbin/nologin" >> /etc/passwd

# Key gen for www-data
cd /home/www-data/.ssh
sudo -u www-data ssh-keygen -t rsa -N "" -f /home/www-data/.ssh/id_rsa
sudo cat /home/www-data/.ssh/id_rsa.pub | cat >> /home/admin/.ssh/authorized_keys

cd /home/www-data

sudo -u www-data echo -e "Host $new_ip\n\tStrictHostKeyChecking no\n" >> /home/www-data/.ssh/config

sudo -u www-data -H git clone admin@$new_ip:/home/admin/admin.git








