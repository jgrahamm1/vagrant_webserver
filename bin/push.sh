#!/usr/bin/env bash

echo "Calling git to push files"
cd ../admin
git add .
git commit
git push

echo "Complete"
