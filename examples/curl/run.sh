#!/usr/bin/env bash
# Run the "Weibo Hot Search Scraper — Trending Topics & Rankings" Apify Actor synchronously and print the dataset items.
# Usage: export APIFY_TOKEN=your_apify_token && ./run.sh
set -euo pipefail
: "${APIFY_TOKEN:?Set APIFY_TOKEN first (Apify Console > Settings > API & Integrations)}"

curl -sS -X POST "https://api.apify.com/v2/acts/leadsbrary~weibo-hot-search-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer ${APIFY_TOKEN}" \
  -H "Content-Type: application/json" \
  -d @- <<'JSON'
{
  "maxResults": 3,
  "keywords": [],
  "includePinned": false,
  "includeAds": false,
  "proxyConfiguration": {
    "useApifyProxy": true
  }
}
JSON
