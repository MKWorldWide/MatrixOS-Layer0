#!/bin/bash

# TrafficFlou Amplify Startup Script
# Quantum-detailed: Handles Primal Genesis Web Interface startup on AWS Amplify
# Manages environment variables, logging, and service initialization

set -e

echo "🚀 Starting TrafficFlou Primal Genesis Web Interface..."

# Set default environment variables if not provided
export PYTHONPATH="${PYTHONPATH}:${PWD}"
export LOG_LEVEL="${LOG_LEVEL:-INFO}"
export HOST="${HOST:-0.0.0.0}"
export PORT="${PORT:-8080}"

# Create necessary directories
mkdir -p logs
mkdir -p tmp

# Set up logging
export TRAFFICFLOU_LOG_FILE="${TRAFFICFLOU_LOG_FILE:-logs/trafficflou.log}"

echo "📋 Environment Configuration:"
echo "  - Python Path: ${PYTHONPATH}"
echo "  - Log Level: ${LOG_LEVEL}"
echo "  - Host: ${HOST}"
echo "  - Port: ${PORT}"
echo "  - Log File: ${TRAFFICFLOU_LOG_FILE}"

# Check if we're in development or production
if [ "$AMPLIFY_ENV" = "dev" ]; then
    echo "🔧 Development Mode"
    export ENVIRONMENT="development"
else
    echo "🏭 Production Mode"
    export ENVIRONMENT="production"
fi

# Start the FastAPI application
echo "🌟 Launching Primal Genesis Engine Sovereign..."
exec python primal_genesis_web_interface.py 