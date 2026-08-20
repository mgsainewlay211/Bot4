#!/bin/bash
# Re-usable 24/7 background deployment script for Telegram bots
cd "$(dirname "$0")/.."
nohup python3 -u bot.py > bot.log 2>&1 &
echo $! > bot.pid
echo "Bot started with PID $(cat bot.pid) in background (24/7 mode)."
