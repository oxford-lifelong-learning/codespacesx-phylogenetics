#!/usr/bin/env bash
set -euo pipefail

# NB: this is run as non-root user because devcontainer.json specifies "remoteUser": "ubuntu"

log() { printf '[post-create.sh] %s\n' "$*" >&2; }
log "post-create.sh launched"

: "${USERNAME:?USERNAME not set}"

# Copy practical directory if it does not already exist
log "Copying practical directory if it does not already exist"
if [ ! -d "/home/${USERNAME}/work/practical" ]; then
  cp -r /workspaces/codespacesx-phylogenetics/practical /home/${USERNAME}/work/
fi

# Write CodespacesX URL and JupyterLab URL
log "Launching write-urls.sh ..."
/opt/codespacesx/write-urls.sh

# Read JupyterLab URL from file
JUPYTER_LAB_URL_FILE="/usr/local/share/codespacesx/JUPYTER_LAB_URL"

if [ -f "$JUPYTER_LAB_URL_FILE" ]; then
  export JUPYTER_LAB_URL="$(tr -d '\r\n' < "$JUPYTER_LAB_URL_FILE")"
  log "Read JupyterLab URL: ${JUPYTER_LAB_URL}"
else
  log "Missing JUPYTER_LAB_URL file: ${JUPYTER_LAB_URL_FILE}"
  exit 1
fi

# Construct the welcome message
log "Writing /home/${USERNAME}/README.md"
envsubst '$JUPYTER_LAB_URL' < /opt/codespacesx/post-entry/README.md > /home/${USERNAME}/README.md
cp /opt/codespacesx/post-entry/ou-logo.png /home/${USERNAME}/ou-logo.png