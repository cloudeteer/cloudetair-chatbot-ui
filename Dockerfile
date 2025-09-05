# Start from the official LibreChat image (prebuilt)
FROM ghcr.io/danny-avila/librechat:v0.7.9

# Switch to app directory and copy customizations
# -> overwrites existing files (JS, CSS, images, etc.)
WORKDIR /app
COPY --chown=node:node . .

# Temporarily switch to root to install the entrypoint script
USER root
RUN \
  mv entrypoint.sh / && \
  chown root:root /entrypoint.sh && \
  chmod 755 /entrypoint.sh

# Set the entrypoint for the container
ENTRYPOINT ["/entrypoint.sh"]

# Redefine the default command from the upstream Dockerfile
CMD ["npm", "run", "backend"]

# Revert back to the non-root node user for safety
USER node

# Reinstall dependencies to ensure a clean rebuild
RUN \
  npm config set fetch-retry-maxtimeout 600000 && \
  npm config set fetch-retries 5 && \
  npm config set fetch-retry-mintimeout 15000 && \
  npm install --no-audit

# Rebuild the frontend with custom overrides
# -> applies new JS, CSS, images, etc.
RUN \
  NODE_OPTIONS="--max-old-space-size=2048" npm run frontend && \
  npm prune --production && \
  npm cache clean --force
