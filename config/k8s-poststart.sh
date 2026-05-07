#!/bin/bash

set -e  # Exit on error

# Check if all required environment variables are set
if [ -z "$BUGSNAG_ENV" ] || [ -z "$BUGSNAG_APP_VERSION" ] || [ -z "$BUGSNAG_API_KEY" ]; then
  echo "Warning: One or more required Bugsnag environment variables are not set. Skipping deployment notification."
  echo "Required: BUGSNAG_ENV, BUGSNAG_APP_VERSION, BUGSNAG_API_KEY"
  exit 0
fi

echo "Notifying Bugsnag of deployment: $BUGSNAG_APP_VERSION to $BUGSNAG_ENV"

# Notify BugSnag about the deployment
PAYLOAD='{
    "apiKey": "'"$BUGSNAG_API_KEY"'",
    "appVersion": "'"$BUGSNAG_APP_VERSION"'",
    "releaseStage": "'"$BUGSNAG_ENV"'",
    "builderName": "Deployer"
  }'

# We use wget instead of curl since the library is no longer included in the etherpad image
if wget -q -O - \
  --tries=3 \
  --header="Content-Type: application/json" \
  --post-data="$PAYLOAD" \
  https://build.bugsnag.com/; then
  echo "Successfully notified Bugsnag"
  exit 0
else
  echo "Warning: Failed to notify Bugsnag (exit code: $?). Continuing anyway..."
  exit 0
fi
