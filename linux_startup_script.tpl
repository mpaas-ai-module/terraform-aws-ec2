#!/bin/bash
sudo adduser admin
sudo adduser admin --disabled-password
usermod -a -G sudo admin
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
cd
mkdir elasticagent1
cd /elasticagent1
curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-linux-x86_64.tar.gz
tar xzvf elastic-agent-8.8.1-linux-x86_64.tar.gz
cd elastic-agent-8.8.1-linux-x86_64
sudo ./elastic-agent install --url=https://6d7f607d7dde4bebb494f4442612e81c.fleet.asia-south1.gcp.elastic-cloud.com:443 --enrollment-token=REDACTED --force --tag aws,linux
rm -rf elasticagent1