#!/bin/sh
set -e

SECRET_FILE="/run/secrets/velocity_forwarding"
SETTINGS_FILE="/server/settings.yml"
JAR_PATH="/server/NanoLimbo.jar"
JAR_URL="https://github.com/Nan1t/NanoLimbo/releases/download/v1.8.1/NanoLimbo-1.8.1-all.jar"

# 1. Replace placeholder with secret (if both exist)
if [ -f "$SECRET_FILE" ]; then
  echo "Loading secret from $SECRET_FILE..."
  SECRET_VALUE=$(cat "$SECRET_FILE" | tr -d '\r\n')  # remove newlines just in case

  if [ -f "$SETTINGS_FILE" ]; then
    echo "Replacing placeholder in $SETTINGS_FILE..."
    sed -i "s|\${CLOUD_VELOCITY_FORWARDING_SECRET}|${SECRET_VALUE}|g" "$SETTINGS_FILE"
  else
    echo "Warning: $SETTINGS_FILE not found, skipping substitution."
  fi
else
  echo "Warning: Secret file $SECRET_FILE not found, skipping substitution."
fi

# 2. Download NanoLimbo if missing
if [ ! -f "$JAR_PATH" ]; then
  echo "Downloading NanoLimbo..."
  curl -fsSL -o "$JAR_PATH" "$JAR_URL"
else
  echo "NanoLimbo.jar already exists, skipping download."
fi

# 3. Run NanoLimbo
echo "Starting NanoLimbo..."
exec java -jar "$JAR_PATH"
