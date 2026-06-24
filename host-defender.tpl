#!/bin/bash

sudo adduser admin
sudo adduser admin --disabled-password
usermod -a -G sudo admin
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
sudo su
sudo apt-get install -y jq

set -e

export TWISTLOCK_USERNAME="e240e7c5-b4f8-45e3-bc7a-2dff92589ba0"
export TWISTLOCK_PASSWORD="Vxr6G2JpAA04J4jXB/vliXJsYv8="         
TWISTLOCK_URL="https://asia-south1.cloud.twistlock.com/india-1131963681"

echo "Fetching authorization token..."
AUTH_RESPONSE=$(curl -s -k \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{
         "username":"'"$TWISTLOCK_USERNAME"'",
         "password":"'"$TWISTLOCK_PASSWORD"'"
      }' \
  "$TWISTLOCK_URL/api/v33.00/authenticate")

AUTH_TOKEN=$(echo "$AUTH_RESPONSE" | jq -r '.token')

if [ -z "$AUTH_TOKEN" ]; then
  echo "Failed to fetch authorization token. Please check your credentials."
  exit 1
fi

echo "Authorization token fetched successfully."

echo "Installing Defender..."
curl -sSL --header "authorization: Bearer $AUTH_TOKEN" \
  -X POST \
  "$TWISTLOCK_URL/api/v1/scripts/defender.sh" | sudo bash -s -- -c "asia-south1.cloud.twistlock.com" -v --install-host

echo "Defender installation completed."