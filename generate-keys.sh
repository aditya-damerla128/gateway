#!/bin/bash
#
# Generate gateway API keys for users
#
# Usage:
#   ./generate-keys.sh                  # Generate 1 key
#   ./generate-keys.sh 5                # Generate 5 keys
#   ./generate-keys.sh 3 "alice bob charlie"  # Generate 3 keys with labels
#
# Each key is a 64-character random hex string prefixed with "mw_"
# Copy the keys you need into your .env file under GATEWAY_API_KEYS (comma-separated)
#

COUNT=${1:-1}
LABELS=${2:-""}

echo ""
echo "=== Gateway API Key Generator ==="
echo ""

# Convert labels string to array
IFS=' ' read -ra LABEL_ARR <<< "$LABELS"

KEYS=()
for i in $(seq 1 "$COUNT"); do
  KEY="mw_$(openssl rand -hex 32)"
  KEYS+=("$KEY")

  if [ -n "${LABEL_ARR[$((i-1))]}" ]; then
    echo "  ${LABEL_ARR[$((i-1))]}: $KEY"
  else
    echo "  Key $i: $KEY"
  fi
done

echo ""
echo "--- Copy this line into your .env file ---"
echo ""
JOINED=$(IFS=,; echo "${KEYS[*]}")
echo "GATEWAY_API_KEYS=$JOINED"
echo ""
echo "Then restart the gateway: pm2 restart portkey-gateway"
echo ""
