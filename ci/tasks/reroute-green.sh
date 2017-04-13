#!/bin/bash

set -ex

apt-get update && apt-get install -y curl
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

sudo apt-get update
sudo apt-get install cf-cli

cf login -a api.run.pivotal.io -u $USERNAME -p $PASSWORD -o Pivotal-Enablement -s staging --skip-ssl-certification

cf map-route attendee-service-green cfapps.io -n attendee-service-autotomic-vitrifiability

echo "attendee-service green is now at public and temp route"

exit 0
