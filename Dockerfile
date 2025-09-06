# syntax=docker.io/docker/dockerfile:1.7-labs
# Enables --exclude in COPY for better caching of layers

# Use the official LibreChat base image
FROM ghcr.io/danny-avila/librechat:v0.7.9
WORKDIR /app

# Project currently does not define its own package.json
# COPY --chown=node:node package*.json .

# Reinstall dependencies to ensure a clean build
RUN npm config set fetch-retry-maxtimeout 600000 \
  && npm config set fetch-retries 5 \
  && npm config set fetch-retry-mintimeout 15000 \
  && npm install --no-audit

# Copy custom files
# Exclude entrypoint.sh and librechat.yaml for separate handling
# Overwrites upstream assets (CSS, JS, images, etc.)
COPY --chown=node:node \
  --exclude=entrypoint.sh \
  --exclude=librechat.yaml \
  . .

# Rebuild frontend to apply overrides (CSS/JS/images)
# Prune devDependencies and clean npm cache to reduce image size
RUN NODE_OPTIONS="--max-old-space-size=2048" npm run frontend \
  && npm prune --production \
  && npm cache clean --force

# Copy entrypoint script with root permissions (separate layer for caching)
COPY --chown=root:root --chmod=755 entrypoint.sh /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set default command (ENTRYPOINT overrides base image CMD)
CMD ["npm", "run", "backend"]

# Copy configuration file last to avoid rebuilding earlier layers on minor changes
COPY --chown=node:node librechat.yaml .
