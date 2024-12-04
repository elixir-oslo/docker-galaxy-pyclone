#!/bin/bash

# Clear the set_env.sh file
touch /galaxy/server/tools/plot_clusters_prevalence/.env

# Write the environment variables into the set_env.sh file
echo "UPLOAD_IMAGE_ENDPOINT=${UPLOAD_IMAGE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_image/.env
echo "CBIOPORTAL_LOAD_RESOURCE_ENDPOINT=${CBIOPORTAL_LOAD_RESOURCE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_image/.env
echo "IMAGE_BASE_URL=${IMAGE_BASE_URL}" >> /galaxy/server/tools/export_cbioportal_image/.env

touch /galaxy/server/tools/export_cbioportal_timeline/.env

echo "EXPORT_TIMELINE_ENDPOINT=${EXPORT_TIMELINE_ENDPOINT}" >> /galaxy/server/tools/export_cbioportal_timeline/.env

# Create dummy config file if it does not exist
if [ -f /galaxy/server/config/galaxy.yml ]; then
  chown galaxy:galaxy /galaxy/server/config/galaxy.yml
  chmod 644 /galaxy/server/config/galaxy.yml
fi



# Pass control to the default command or any other command specified
exec "$@"