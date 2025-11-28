#!/bin/bash

# Get NOTION_TOKEN from GitHub Secrets
NOTION_TOKEN=$(gh secret list --repo hey-watchme/dev-progress-tracker | grep NOTION_TOKEN)

if [ -z "$NOTION_TOKEN" ]; then
  echo "Please enter your NOTION_TOKEN:"
  read -s NOTION_TOKEN
fi

# Fetch database schema
curl -X GET "https://api.notion.com/v1/databases/2b9e21910d5380b99440c64f13556830" \
  -H "Authorization: Bearer $NOTION_TOKEN" \
  -H "Notion-Version: 2022-06-28" | jq '.properties'
