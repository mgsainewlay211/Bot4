---
name: telegram-bot-orchestrator
description: Comprehensive workflow for consolidating, optimizing, and deploying high-performance Telegram automation and scanning bots. Use for merging multiple bot scripts, implementing worker-pool asynchronous pipelines, setting up 24/7 background execution, session validation, and immediate push notifications.
---

# Telegram Bot Orchestrator

This skill provides a structured methodology for merging, optimizing, and deploying robust Telegram bots designed for high-throughput automated tasks such as credential verification, brute-force scanning, and portal integrations.

## Core Configuration & Templates

Before deploying or running a consolidated bot script, ensure that all essential parameters are configured. Use the provided `templates/config.json.example` as a baseline reference for setting up environment variables and repository connectors.

### Essential Configuration Parameters
- **Bot Token**: Provided via Telegram BotFather (`BOT_TOKEN`).
- **Admin ID**: Telegram numeric ID for administrative command authorization (`ADMIN_ID`).
- **GitHub Integration**: Personal Access Token (`GITHUB_TOKEN`), repository owner (`REPO_OWNER`), and repository name (`REPO_NAME`) for persistent result synchronization.
- **Concurrency**: Worker pool limit (recommended: `300` to `400` for high-speed scanning without triggering server rate limits).
- **Web Port**: Port for keep-alive web server (default: `5000`).

## Core Workflow

The orchestration process encompasses script consolidation, asynchronous worker-pool implementation, session health monitoring, and persistent background deployment.

### 1. Environment Setup & Script Consolidation
Execute the bundled environment setup script (`scripts/setup_env.sh`) to install system dependencies (OpenCV, python packages, ddddocr). When provided with multiple disparate script files, consolidate them into a single, cohesive asynchronous script structure (`bot.py`). Ensure that tokens and admin IDs are properly parameterized and injected.

### 2. High-Performance Asynchronous Pipeline
To maximize throughput and prevent blocking, replace traditional synchronous loops or rigid batching with a continuous producer-consumer worker-pool pattern utilizing `asyncio.Queue`. 
- **Connection Reuse**: Maintain a single global `aiohttp.ClientSession` backed by an optimized `TCPConnector` with connection pooling enabled.
- **Adaptive Rate Limiting**: Implement intelligent backoff mechanisms that detect server rate limits (`request limited`) and adjust pacing dynamically to prevent IP blocking.

### 3. Session Validation & Health Monitoring
Portal authentication bots require strict session validation. Implement robust URL parsing logic that handles special characters, parameter normalization, and MAC address injection. Ensure that session health is continuously verified through periodic checks during execution to auto-terminate invalid sessions and notify users promptly.

### 4. Persistent 24/7 Deployment & Notifications
Deploy the bot as a background process using the bundled deployment script (`scripts/deploy_bot.sh`) which combines `nohup` with a keep-alive lightweight web server. Configure immediate push notification alerts for successful findings complete with precise timestamps, plan details, and persistent storage synchronization.

## Reference Materials
- Consult the [Architecture Guide](references/architecture-guide.md) for detailed patterns on asynchronous worker queues and connection pooling configurations.
- Use the configuration template in `templates/config.json.example` for secure parameter management.
