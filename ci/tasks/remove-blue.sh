#!/bin/bash

wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update
sudo apt-get install cf-cli

cf login -a api.run.pivotal.io -u $USERNAME -p $PASSWORD -o Pivotal-Enablement -s staging --skip-ssl-certification

cf unmap-route attendee-service cfapps.io -n attendee-service-autotomic-vitrifiability

echo "blue is no longer at pubic route"

cf unmap-route attendee-service-green cfapps.io -n attendee-service-autotomic-vitrifiability-temp

echo "green is no longer at private route"

cf delete attendee-service

echo "blue is no longer on cf"

cf rename attendee-service-green attendee-service

echo "green is now named attendee-service"

exit 0
