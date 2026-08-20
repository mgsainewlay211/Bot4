# Telegram Bot Architecture & Optimization Guide

This guide details the high-performance architecture developed for automation and scanning bots (such as Ruijie Portal voucher scanners).

## 1. High-Speed Worker-Pool Pattern (`asyncio.Queue`)
Instead of batch-blocking requests, use a producer-consumer model:
- **Producer**: Generates codes continuously and puts them into an `asyncio.Queue`.
- **Workers**: Multiple concurrent worker coroutines pull codes from the queue and perform HTTP checks asynchronously.
- **Benefits**: Eliminates idle time between batches, maximizes throughput, and maintains smooth progress updates.

## 2. Session Reuse & Connection Pooling
- Avoid creating a new `ClientSession` for every request.
- Use a single global `aiohttp.ClientSession` paired with a robust `TCPConnector` (with high limits, e.g., `limit=5000`, `ttl_dns_cache=300`, `ssl=True`).

## 3. Real-Time Session Health Checks & Validation
- Validate portal session URLs before starting scans by fetching CAPTCHA endpoints or checking session redirects.
- Implement periodic health checks (e.g., every 3 minutes) during long-running tasks to auto-stop if a session expires.

## 4. 24/7 Background Deployment
- Combine `nohup python3 -u bot.py > bot.log 2>&1 &` with a keep-alive lightweight `aiohttp` web server (listening on port 5000) to ensure the instance stays awake and responsive in cloud or VPS environments.
