# Deploy and Host SearXNG with Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/L3RC34?referralCode=ZVzVcL&utm_medium=integration&utm_source=template&utm_campaign=generic)

SearXNG is a free, open-source, privacy-respecting meta-search engine that aggregates results from over 70 search services without tracking users or storing search history.

## About Hosting SearXNG

Hosting SearXNG gives you a private search engine under your own control. Because SearXNG proxies queries to upstream search engines, it requires no database and holds no persistent state — making it one of the lightest services to run. The main operational concern is keeping the secret key consistent across redeployments (so existing sessions stay valid) and optionally restricting admin access with a password. Railway handles TLS termination, health checking via `/healthz`, and automatic restarts on failure.

## Common Use Cases

- **Personal privacy search** — stop being tracked across searches by Google, Bing, and similar services
- **Team or org-internal search portal** — deploy once, share the URL internally
- **Self-hosted alternative to DuckDuckGo** — full control over which engines are enabled and weighted
- **Research and OSINT** — aggregate results from multiple engines simultaneously without fingerprinting
- **Development and testing** — inspect and modify the search pipeline without third-party rate limits

## Dependencies for SearXNG Hosting

SearXNG is a single-service deployment with no external dependencies:

- **SearXNG** — the search engine itself (Python/Flask, runs as a single container)

### Deployment Dependencies

- [SearXNG Docker image](https://hub.docker.com/r/searxng/searxng)
- [SearXNG documentation](https://docs.searxng.org/)
- [SearXNG settings reference](https://docs.searxng.org/admin/settings/index.html)

### Implementation Details

`SEARXNG_SECRET_KEY` is injected into `settings.yml` at container startup via `entrypoint.sh`. It must be a consistent hex string across redeployments — the Railway template variable function `${{secret(64, "abcdef0123456789")}}` generates a stable value per deploy.

`SEARXNG_ADMIN_PASSWORD`, if set, enables password-protected access to the admin preferences panel at `/preferences`.

### Why Deploy SearXNG on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying SearXNG on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.

---

## Environment Variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `SEARXNG_SECRET_KEY` | Yes | `${{secret(64, "abcdef0123456789")}}` | Cryptographic secret for session signing. Must be stable across redeployments. |
| `SEARXNG_ADMIN_PASSWORD` | No | — | Password for the admin preferences panel. Leave unset to allow open access. |

## Developer Deploy

```bash
make deploy RAILWAY_PROJECT=my-project
# SECRET_KEY and ADMIN_PASSWORD are auto-generated
```
