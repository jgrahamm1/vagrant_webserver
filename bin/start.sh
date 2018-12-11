#!/usr/bin/env bash

echo "Calling vagrant up..."
cd ../v_env
vagrant up


echo "Retreiving IP and making changes..."
newip=$(vagrant ssh -c "ip address show eth1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//'")

echo $new_ip > ../bin/ip_state

echo "Complete"

