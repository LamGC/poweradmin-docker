#!/bin/bash

LATEST_VERSION=$(curl -s https://api.github.com/repos/jenkinsci/docker-agent/releases/latest | grep tag_name | cut -d '"' -f 4)

if [ -z "$LATEST_VERSION" ]; then
  echo "Failed to fetch the latest version. Exiting."
  exit 1
fi

if [ "$LATEST_VERSION" != "$(cat LATEST_VERSION)" ]; then
    echo "$LATEST_VERSION" > LATEST_VERSION
fi
