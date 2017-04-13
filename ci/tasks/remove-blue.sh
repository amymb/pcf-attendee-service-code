#!/bin/bash

set -ex


apt-get update && apt-get install -y curl
apt-get install sudo

# ...download & extract Mac OS X binary
curl -L "https://cli.run.pivotal.io/stable?release=macosx64-binary&source=github" | tar -zx
# ...or Linux 64-bit binary
curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
# ...move it to /usr/local/bin or a location you know is in your $PATH
mv cf /usr/local/bin
# ...copy tab completion file on Ubuntu (takes affect after re-opening your shell)
sudo curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf
# ...and to confirm your cf CLI version
cf --version

cf login -a api.run.pivotal.io -u $USERNAME -p $PASSWORD -o Pivotal-Enablement -s staging --skip-ssl-validation

cf unmap-route attendee-service cfapps.io -n attendee-service-autotomic-vitrifiability

echo "blue is no longer at pubic route"

cf unmap-route attendee-service-green cfapps.io -n attendee-service-autotomic-vitrifiability-test

echo "green is no longer at private route"

cf delete attendee-service

echo "blue is no longer on cf"

cf rename attendee-service-green attendee-service

echo "green is now named attendee-service"

exit 0
