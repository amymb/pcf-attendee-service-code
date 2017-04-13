#!/bin/bash

set -ex

apt-get update && apt-get install -y wget
apt-get install sudo
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update

sudo apt-get install cf-cli

cf login -a api.run.pivotal.io -u $USERNAME -p $PASSWORD -o Pivotal-Enablement -s staging --skip-ssl-certification

cf map-route attendee-service-green cfapps.io -n attendee-service-autotomic-vitrifiability

echo "attendee-service green is now at public and temp route"

exit 0
