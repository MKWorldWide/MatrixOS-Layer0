#!/usr/bin/env python3
"""
TrafficFlou Amplify Startup Script
Quantum-detailed: Handles Primal Genesis Web Interface startup on AWS Amplify
Manages environment variables, port configuration, and service initialization
"""

import os
import sys
import uvicorn
from primal_genesis_web_interface import app

def main():
    """Main startup function for Amplify deployment"""
    
    # Get configuration from environment variables
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "8080"))
    debug = os.getenv("DEBUG", "false").lower() == "true"
    log_level = os.getenv("LOG_LEVEL", "info")
    
    # Set up environment
    os.environ["PYTHONPATH"] = f"{os.getcwd()}:{os.environ.get('PYTHONPATH', '')}"
    
    print("🚀 TrafficFlou Primal Genesis Engine Sovereign")
    print("Quantum-level traffic generation with mystical capabilities")
    print(f"🌐 Starting web interface on http://{host}:{port}")
    print(f"🔧 Debug mode: {debug}")
    print(f"📝 Log level: {log_level}")
    print("Press Ctrl+C to stop")
    
    # Start the FastAPI application
    uvicorn.run(
        app,
        host=host,
        port=port,
        reload=debug,
        log_level=log_level
    )

if __name__ == "__main__":
    main() 