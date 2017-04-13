#!/bin/bash

set -ex

apt-get update && apt-get install -y curl

if [ -z $ATTENDEE_SERVICE_URL ]; then
  echo "ATTENDEE_SERVICE_URL not set"
  exit 1
fi

pushd attendee-service-source
  echo "Running smoke tests the first time for Attendee Service deployed at $ATTENDEE_SERVICE_URL"
  smoke-tests/bin/test $ATTENDEE_SERVICE_URL
popd

pushd attendee-service-source
  echo "Running smoke tests the second time for Attendee Service deployed at $ATTENDEE_SERVICE_URL"
  smoke-tests/bin/test $ATTENDEE_SERVICE_URL
popd


pushd attendee-service-source
  echo "Running smoke tests the third time for  Attendee Service deployed at $ATTENDEE_SERVICE_URL"
  smoke-tests/bin/test $ATTENDEE_SERVICE_URL
popd

pushd attendee-service-source
  echo "Running smoke tests the last time for Attendee Service deployed at $ATTENDEE_SERVICE_URL"
  smoke-tests/bin/test $ATTENDEE_SERVICE_URL
popd

exit 0
