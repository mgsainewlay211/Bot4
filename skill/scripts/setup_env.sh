#!/bin/bash
# Environment setup script for high-performance automation and scanning bots
echo "Updating package lists and installing dependencies..."
sudo apt-get update && sudo apt-get install -y python3-pip python3-opencv poppler-utils git curl

echo "Installing required Python packages..."
pip3 install --upgrade pip
pip3 install pyTelegramBotAPI aiohttp opencv-python ddddocr numpy

echo "Environment setup complete!"
