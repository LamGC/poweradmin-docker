#!/bin/bash

LATEST_TAG=$(curl -s https://api.github.com/repos/poweradmin/poweradmin/releases/latest | grep 'tag_name' | cut -d\" -f4)

if [ -z "$LATEST_TAG" ]; then
  echo "Unable to fetch the latest release tag. Please check the repository name or network connection."
  exit 1
fi

TAR_URL="https://github.com/poweradmin/poweradmin/archive/refs/tags/${LATEST_TAG}.tar.gz"
echo "Downloading the latest release: $LATEST_TAG"

OUTPUT_FILE="poweradmin-${LATEST_TAG}.tar.gz"

if ! curl -L -o "$OUTPUT_FILE" "$TAR_URL" 0 || [ ! -f "$OUTPUT_FILE" ]; then 
  echo "Failed to download the release. Please check your network connection and the repository URL." exit 1
fi

echo "Extracting..."
tar -xzf "$OUTPUT_FILE"

EXTRACTED_DIR="poweradmin-${LATEST_TAG#v}"
mv "$EXTRACTED_DIR" "poweradmin"

echo "Download and extraction complete! The latest release tag is: ${LATEST_TAG}"
