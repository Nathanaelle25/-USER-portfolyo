#!/bin/bash
# Automate Better Stack Uptime Monitor Creation targeting the /health endpoint
# This script uses the Better Stack Uptime API (v2) to autonomously register a monitor for your deployed application.

# Usage: ./setup-betterstack.sh <BETTER_STACK_API_TOKEN> <DEPLOYED_URL>
# Example: ./setup-betterstack.sh "your_token_here" "https://nathanaelle.dev"

API_TOKEN=$1
TARGET_URL=$2

if [ -z "$API_TOKEN" ] || [ -z "$TARGET_URL" ]; then
  echo "Error: Missing arguments."
  echo "Usage: ./setup-betterstack.sh <API_TOKEN> <TARGET_URL>"
  exit 1
fi

HEALTH_URL="${TARGET_URL}/health"

echo "Creating Better Stack Uptime monitor for $HEALTH_URL..."

# Send POST request to Better Stack API using standard curl (pre-installed on most CI/CD runners)
RESPONSE=$(curl -s -X POST "https://uptime.betterstack.com/api/v2/monitors" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "'$HEALTH_URL'",
    "monitor_type": "status",
    "pronounceable_name": "Portfolyo Production Health Gate",
    "verify_ssl": true,
    "check_frequency": 180,
    "recovery_period": 180,
    "confirmation_period": 0,
    "http_method": "GET"
  }')

echo ""
echo "API Response:"
echo $RESPONSE | grep -o '"id":\"[^\"]*\"' || echo "Creation potentially failed. Check Response:" $RESPONSE
echo ""
echo "Done. If successful, your monitor is now active on Better Stack."
