#!/usr/bin/env bash

echo "Cloning git repository to /admin"

# Get IP
cd ../v_env
new="$(vagrant ssh -c "ip address show eth1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//' | tr -d '\n'" 2>/dev/null)"



# Clone
cd ..
git clone admin@$new:/home/admin/admin.git

echo "Complete"
