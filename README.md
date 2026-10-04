# Weibo Hot Search Scraper — Trending Topics & Rankings — Apify Actor usage guide

[![Run on Apify](https://img.shields.io/badge/Apify-Run%20this%20Actor-24C1E0)](https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara)
[![Try Apify free](https://img.shields.io/badge/Apify-Try%20it%20free-24C1E0)](https://console.apify.com/sign-up?fpr=aupara)

Scrape the live Weibo hot search (微博热搜) board: rank, keyword, heat, label, category and search URL for each trending topic. No login. Export JSON, CSV, Excel. From $1 per 1,000 results.

> **This repository does not contain the Actor's source code.** The Actor is closed-source and
> runs on Apify's infrastructure. This repo is documentation plus ready-to-run client examples
> (curl, Python, JavaScript) that call the hosted Actor with **your own** Apify API token.

**Run it on Apify →** [https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara](https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara)

## What it does

Scrape the live Weibo hot search (微博热搜) board: rank, keyword, heat, label, category and search URL for each trending topic. No login. Export JSON, CSV, Excel. From $1 per 1,000 results.

## Use cases

- Scheduled (hourly/daily) snapshot of the Weibo top-50 hot-search ranking into a dataset, Google Sheet or webhook
- Keyword / brand rank-tracking over time by filtering topics that contain given keywords across scheduled snapshots
- Feeding Chinese trending topics into newsrooms, dashboards or LLM summarisation pipelines
- China-market research: which categories (entertainment, society, tech…) dominate the trending list


## Input

| Field | Type | Required | Description |
|---|---|---|---|
| `maxResults` | integer | no | Maximum number of hot-search topics to return (the board has about 50). Also caps your spending. |
| `keywords` | array | no | Optional. Only return topics containing at least one of these strings (case-insensitive, Chinese or Latin). Leave empty for all topics. |
| `includePinned` | boolean | no | Also return the pinned/official topic shown above the ranking (rank is null, isPinned is true). |
| `includeAds` | boolean | no | Also return unranked/promoted entries if the board contains any (isAd is true). |
| `proxyConfiguration` | object | no | Apify datacenter proxy is enough for this board. |

The full input form (with defaults and validation) is on the [Actor page](https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara).


## Output (sample item)

Sample trimmed for readability (long texts and lists are shortened) — a real run returns the complete data.

```json
{
  "rank": null,
  "keyword": "#总书记赞誉的爱国者#",
  "heat": null,
  "label": "热",
  "category": null,
  "isPinned": true,
  "isAd": false,
  "searchUrl": "https://s.weibo.com/weibo?q=%23%E6%80%BB%E4%B9%A6%E8%AE%B0%E8%B5%9E%E8%AA%89%E7%9A%84%E7%88%B1%E5%9B%BD%E8%80%85%23",
  "topicId": "449f186091e4",
  "source": "hot_band",
  "onboardAt": "2026-10-03T12:38:33.000Z",
  "snapshotAt": "2026-10-03T23:43:58.942Z"
}
```

## Pricing

Pay only for results: about **$1.50 per 1,000 results** on the Apify Free plan, down to **$1.00 per 1,000** on paid Apify plans.

Apify platform usage (compute) is billed by Apify on top of the per-result price — about **$0.01 per 1,000 results** in our measured test runs (estimate, varies with input). Tip: keep only the output formats and options you need to reduce it.

Prices can change — the [Actor page](https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara) always shows the current pricing.

## Quick start

You need an Apify account and an API token (Apify Console → **Settings → API & Integrations**).
Never commit your token: export it as the `APIFY_TOKEN` environment variable.

### cURL

```bash
curl -X POST "https://api.apify.com/v2/acts/leadsbrary~weibo-hot-search-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer $APIFY_TOKEN" \
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
```

### Python (`apify-client`)

```python
import os
from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

run_input = {
    "maxResults": 3,
    "keywords": [],
    "includePinned": False,
    "includeAds": False,
    "proxyConfiguration": {
        "useApifyProxy": True
    }
}

run = client.actor("leadsbrary/weibo-hot-search-scraper").call(run_input=run_input)
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item)
```

### JavaScript (`apify-client`)

```javascript
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

const runInput = {
  "maxResults": 3,
  "keywords": [],
  "includePinned": false,
  "includeAds": false,
  "proxyConfiguration": {
    "useApifyProxy": true
  }
};

const run = await client.actor('leadsbrary/weibo-hot-search-scraper').call(runInput);
const { items } = await client.dataset(run.defaultDatasetId).listItems();
console.log(items);
```

Runnable versions live in [`examples/`](./examples).

## Troubleshooting

- **401 / "User was not found or authentication token is not valid"** — check that `APIFY_TOKEN` is set and copied completely.
- **The run finished but the dataset is empty** — widen your search input or check the run log on the Apify Console.
- **Run stops early** — you may have reached the maximum cost per run you set in Apify; raise it in the run options.
- **Need something else?** Open an issue in this repository or use the Issues tab on the Actor page.

## Don't have an Apify account yet?

[Sign up here](https://console.apify.com/sign-up?fpr=aupara) — new accounts get $5 of free platform usage every month, enough to try most Actors without paying upfront.
Browse the full [Apify Store](https://apify.com/store?fpr=aupara) or [all Actors from this developer](https://apify.com/leadsbrary?fpr=aupara).

## Links

- Actor page: [https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara](https://apify.com/leadsbrary/weibo-hot-search-scraper?fpr=aupara)
- All Actors from this developer: [https://apify.com/leadsbrary?fpr=aupara](https://apify.com/leadsbrary?fpr=aupara)
- Apify API reference: [https://docs.apify.com/api/v2](https://docs.apify.com/api/v2)

## Keywords

weibo hot search scraper, weibo trending scraper, weibo hot search api, weibo hot topics, weibo scraper, 微博热搜, weibo trending topics, china social media monitoring, weibo rank tracking, chinese trending topics, weibo hot list export

#weibo #weibohotsearch #weibotrending #chinasocialmedia #trendingtopics #socialmediamonitoring #brandmonitoring #chinamarket #webscraping #apify

## License

The example code in this repository is released under the MIT License — see [LICENSE](./LICENSE).
It does not cover the Actor itself, which remains closed-source and is operated by its developer on Apify.
