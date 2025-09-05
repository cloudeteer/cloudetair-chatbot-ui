#!/bin/sh

# CONTAINER_APP_HOSTNAME is automatically provided by Azure Container App Service
# and contains the fully qualified domain name (FQDN) of this container instance.

# Set DOMAIN_CLIENT and DOMAIN_SERVER only if they are not already defined
# and if CONTAINER_APP_HOSTNAME is available.
if [ -z "$DOMAIN_CLIENT" ] && [ -n "$CONTAINER_APP_HOSTNAME" ]; then
  export DOMAIN_CLIENT="https://$CONTAINER_APP_HOSTNAME"
fi
if [ -z "$DOMAIN_SERVER" ] && [ -n "$CONTAINER_APP_HOSTNAME" ]; then
  export DOMAIN_SERVER="https://$CONTAINER_APP_HOSTNAME"
fi

# Start the main application process
exec "$@"
