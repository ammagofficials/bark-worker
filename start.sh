#!/bin/bash
set -e

# Install requirements
pip install -r requirements.txt

# Install soundfile manually (requires binary wheels)
pip install soundfile

# Install Bark from GitHub (last, as it can be fragile)
pip install git+https://github.com/suno-ai/bark.git

# Finally run your app
python main.py
