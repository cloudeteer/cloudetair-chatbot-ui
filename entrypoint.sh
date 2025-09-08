#!/bin/sh

# CONTAINER_APP_HOSTNAME is automatically provided by Azure Container App Service
# and contains the fully qualified domain name (FQDN) of this container instance.

# Set DOMAIN_CLIENT and DOMAIN_SERVER only if they are not already defined
# and if CONTAINER_APP_ENV_DNS_SUFFIX and CONTAINER_APP_NAME is available.
#
# CONTAINER_APP_ENV_DNS_SUFFIX and CONTAINER_APP_NAME are used to construct the application URL,
# as CONTAINER_APP_HOSTNAME includes the deployment revision, which is not suitable for OAuth flows.
if [ -z "$DOMAIN_CLIENT" ] && [ -n "$CONTAINER_APP_ENV_DNS_SUFFIX" ] && [ -n "$CONTAINER_APP_NAME" ]; then
  export DOMAIN_CLIENT="https://${CONTAINER_APP_NAME}.${CONTAINER_APP_ENV_DNS_SUFFIX}"
fi
if [ -z "$DOMAIN_SERVER" ] && [ -n "$CONTAINER_APP_ENV_DNS_SUFFIX" ] && [ -n "$CONTAINER_APP_NAME" ]; then
  export DOMAIN_SERVER="https://${CONTAINER_APP_NAME}.${CONTAINER_APP_ENV_DNS_SUFFIX}"
fi

# Start the main application process
exec "$@"
