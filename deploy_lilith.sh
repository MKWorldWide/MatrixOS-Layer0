#!/bin/bash

# =============================================================================
# 🚀 LILITH ENHANCED TRAFFICFLOU DEPLOYMENT SCRIPT
# =============================================================================
# Quick deployment script for enhanced TrafficFlou with 7x traffic increase
# Features: Multi-page GameDin.xyz targeting, exponential acceleration
# =============================================================================

echo "🚀 LILITH ENHANCED TRAFFICFLOU DEPLOYMENT"
echo "=========================================="
echo "🎯 7x Traffic Increase + Multi-Page Targeting"
echo "📈 Exponential Acceleration Enabled"
echo "🔄 Continuous Operation"
echo ""

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 not found. Please install Python 3.8+"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📦 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements_minimal.txt

# Validate configuration
echo "✅ Validating configuration..."
python3 -c "from src.core.config import validate_config; print('✅ Configuration valid' if validate_config() else '❌ Configuration invalid')"

# Run enhanced traffic generator
echo ""
echo "🚀 Starting Enhanced GameDin.xyz Multi-Page Traffic Generation..."
echo "📊 7x Traffic Increase + Exponential Acceleration"
echo "🎯 Targeting all GameDin.xyz pages"
echo ""

# Run the enhanced generator
python3 enhanced_gamedin_traffic_generator.py

echo ""
echo "🎉 LILITH ENHANCED TRAFFICFLOU DEPLOYMENT COMPLETE!"
echo "📊 Check the results above for traffic generation statistics"
echo ""
echo "🔄 To run continuously, use: python3 run_accelerator.py"
echo "📈 To monitor performance, check the logs"
echo ""
echo "🚀 Mission Accomplished! 🚀" 