#!/usr/bin/env bash

echo "Calling vagrant destroy.."
cd ../v_env
vagrant destroy

echo "Cleaning up directories..."
cd ..
rm -rf ./admin
rm -rf ./v_env

echo "Complete"
