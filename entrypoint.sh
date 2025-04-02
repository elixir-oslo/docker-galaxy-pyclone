#!/bin/bash

# Create dummy config file if it does not exist
if [ -f /config/galaxy.yml ]; then
  echo "Using existing config file"
  rm /galaxy/server/config/galaxy.yml
  touch /galaxy/server/config/galaxy.yml
  cp /config/galaxy.yml /config/galaxy.yml.bak
#  cp /config/galaxy.yml /galaxy/server/config/galaxy.yml
  chown galaxy:galaxy /config/galaxy.yml.bak
  ln -s /config/galaxy.yml.bak /galaxy/server/config/galaxy.yml
fi

# Change user to galaxy here
# Switch to the galaxy user
#if [ "$USER" != "galaxy" ]; then
#  # Use gosu to switch to the galaxy user for subsequent commands
#  if command -v gosu &>/dev/null; then
#    exec gosu galaxy "$0" "$@"
#  else
#    echo "Error: gosu not found."
#    exit 1
#  fi
#fi

# Clear the set_env.sh file
touch /galaxy/server/tools/plot_clusters_prevalence/.env

# Write the environment variables into the set_env.sh file
echo "UPLOAD_IMAGE_ENDPOINT=${UPLOAD_IMAGE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_image/.env
echo "CBIOPORTAL_LOAD_RESOURCE_ENDPOINT=${CBIOPORTAL_LOAD_RESOURCE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_image/.env
echo "IMAGE_BASE_URL=${IMAGE_BASE_URL}" >> /galaxy/server/tools/export_cbioportal_image/.env

touch /galaxy/server/tools/export_cbioportal_timeline/.env

echo "EXPORT_TIMELINE_ENDPOINT=${EXPORT_TIMELINE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_timeline/.env


# Create a custom directory for certificates
mkdir -p /galaxy/custom-ca-certificates

# Copy certificates from the mounted directory to the custom directory
if [ -d "/ssl" ]; then
    cp /ssl/*.crt /galaxy/custom-ca-certificates/
fi

# Set the SSL_CERT_DIR environment variable to the custom directory
export SSL_CERT_DIR=/galaxy/custom-ca-certificates

# Pass control to the default command or any other command specified
exec "$@"