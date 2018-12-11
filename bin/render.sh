#!/usr/bin/env bash
cd ../v_env

new="$(vagrant ssh -c "ip address show eth1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//' | tr -d '\n'" 2>/dev/null)"

curl -k https://$new
