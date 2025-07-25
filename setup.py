#!/usr/bin/env python3
"""
🚦 TrafficFlou Setup Script

This script helps users set up and configure the TrafficFlou system
for AI-powered traffic generation and redirection.

Author: TrafficFlou Team
Version: 1.0.0
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path
import json


def print_banner():
    """Print the TrafficFlou banner."""
    print("🚦" + "=" * 60)
    print("🚦 TrafficFlou - AI-Powered Organic Traffic Mimicry System")
    print("🚦" + "=" * 60)
    print()


def check_python_version():
    """Check if Python version is compatible."""
    if sys.version_info < (3, 9):
        print("❌ Python 3.9 or higher is required")
        print(f"   Current version: {sys.version}")
        return False
    
    print(f"✅ Python version: {sys.version.split()[0]}")
    return True


def check_dependencies():
    """Check if required system dependencies are available."""
    print("🔍 Checking system dependencies...")
    
    # Check for pip
    try:
        subprocess.run([sys.executable, "-m", "pip", "--version"], 
                      capture_output=True, check=True)
        print("✅ pip is available")
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("❌ pip is not available")
        return False
    
    # Check for git
    try:
        subprocess.run(["git", "--version"], capture_output=True, check=True)
        print("✅ git is available")
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("⚠️  git is not available (optional)")
    
    return True


def install_python_dependencies():
    """Install Python dependencies."""
    print("📦 Installing Python dependencies...")
    
    try:
        # Install dependencies from requirements.txt
        subprocess.run([
            sys.executable, "-m", "pip", "install", "-r", "requirements.txt"
        ], check=True)
        print("✅ Python dependencies installed successfully")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to install Python dependencies: {e}")
        return False


def install_node_dependencies():
    """Install Node.js dependencies for web interface."""
    print("📦 Installing Node.js dependencies...")
    
    # Check if package.json exists
    if not Path("package.json").exists():
        print("⚠️  package.json not found, skipping Node.js dependencies")
        return True
    
    try:
        # Check if npm is available
        subprocess.run(["npm", "--version"], capture_output=True, check=True)
        
        # Install dependencies
        subprocess.run(["npm", "install"], check=True)
        print("✅ Node.js dependencies installed successfully")
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("⚠️  npm not available, skipping Node.js dependencies")
        return True


def create_directories():
    """Create necessary directories."""
    print("📁 Creating directories...")
    
    directories = [
        "logs",
        "config",
        "data",
        "cache",
        "reports"
    ]
    
    for directory in directories:
        Path(directory).mkdir(exist_ok=True)
        print(f"✅ Created directory: {directory}")


def setup_environment():
    """Set up environment configuration."""
    print("⚙️  Setting up environment configuration...")
    
    env_file = Path(".env")
    env_example = Path("env.example")
    
    if env_file.exists():
        print("⚠️  .env file already exists")
        response = input("   Do you want to overwrite it? (y/N): ")
        if response.lower() != 'y':
            print("   Skipping environment setup")
            return True
    
    if env_example.exists():
        shutil.copy(env_example, env_file)
        print("✅ Created .env file from template")
        print("   Please edit .env file with your configuration")
    else:
        print("⚠️  env.example not found, creating basic .env file")
        create_basic_env_file()
    
    return True


def create_basic_env_file():
    """Create a basic .env file."""
    basic_config = """# TrafficFlou Environment Configuration
# Edit this file with your actual configuration

# Core Configuration
TRAFFICFLOU_TARGET_URL=https://example.com
TRAFFICFLOU_TRAFFIC_VOLUME=1000
TRAFFICFLOU_DURATION=3600
TRAFFICFLOU_BEHAVIOR_PROFILE=organic

# AI Model Configuration
TRAFFICFLOU_OPENAI_ENABLED=false
TRAFFICFLOU_OPENAI_API_KEY=your_openai_api_key_here
TRAFFICFLOU_ANTHROPIC_ENABLED=false
TRAFFICFLOU_ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Traffic Generation
TRAFFICFLOU_CONCURRENT_REQUESTS=10
TRAFFICFLOU_REQUEST_DELAY=0.1
TRAFFICFLOU_REQUEST_TIMEOUT=30

# Analytics
TRAFFICFLOU_ANALYTICS_ENABLED=true
TRAFFICFLOU_METRICS_STORAGE_BACKEND=memory

# Logging
TRAFFICFLOU_LOG_LEVEL=INFO
TRAFFICFLOU_LOG_FORMAT=json
TRAFFICFLOU_LOG_FILE_ENABLED=true
"""
    
    with open(".env", "w") as f:
        f.write(basic_config)


def setup_configuration():
    """Set up configuration files."""
    print("⚙️  Setting up configuration files...")
    
    # Create basic configuration files
    config_dir = Path("config")
    config_dir.mkdir(exist_ok=True)
    
    # Traffic profiles configuration
    traffic_profiles = {
        "profiles": {
            "organic": {
                "session_duration": 300,
                "page_views_per_session": 5,
                "bounce_rate": 0.3,
                "description": "Natural browsing behavior"
            },
            "shopping": {
                "session_duration": 600,
                "page_views_per_session": 10,
                "bounce_rate": 0.1,
                "description": "E-commerce shopping behavior"
            },
            "research": {
                "session_duration": 900,
                "page_views_per_session": 15,
                "bounce_rate": 0.05,
                "description": "Research and information gathering"
            }
        }
    }
    
    with open(config_dir / "traffic_profiles.yaml", "w") as f:
        import yaml
        yaml.dump(traffic_profiles, f, default_flow_style=False, indent=2)
    
    print("✅ Created traffic_profiles.yaml")
    
    # AI models configuration
    ai_models_config = {
        "openai": {
            "enabled": False,
            "api_key": "your_openai_api_key_here",
            "model_name": "gpt-4",
            "max_tokens": 1000,
            "temperature": 0.7,
            "timeout": 30,
            "retry_attempts": 3
        },
        "anthropic": {
            "enabled": False,
            "api_key": "your_anthropic_api_key_here",
            "model_name": "claude-3-sonnet-20240229",
            "max_tokens": 1000,
            "temperature": 0.7,
            "timeout": 30,
            "retry_attempts": 3
        },
        "load_balancing": "round_robin",
        "fallback_enabled": True
    }
    
    with open(config_dir / "ai_models.yaml", "w") as f:
        yaml.dump(ai_models_config, f, default_flow_style=False, indent=2)
    
    print("✅ Created ai_models.yaml")


def run_tests():
    """Run basic tests to verify installation."""
    print("🧪 Running basic tests...")
    
    try:
        # Test Python imports
        sys.path.insert(0, str(Path("src")))
        
        # Test basic imports
        import trafficflou
        print("✅ TrafficFlou package imports successfully")
        
        # Test configuration
        from trafficflou import TrafficFlouConfig
        config = TrafficFlouConfig(target_url="https://httpbin.org")
        print("✅ Configuration system works")
        
        return True
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False


def print_next_steps():
    """Print next steps for the user."""
    print("\n" + "=" * 60)
    print("🎉 TrafficFlou setup completed successfully!")
    print("=" * 60)
    print("\n📚 Next steps:")
    print("1. Edit the .env file with your configuration:")
    print("   - Set your target URL")
    print("   - Configure AI model API keys (optional)")
    print("   - Adjust traffic volume and behavior settings")
    print()
    print("2. Run the basic example:")
    print("   python examples/basic_usage.py")
    print()
    print("3. Start the web dashboard (optional):")
    print("   npm run dev")
    print()
    print("4. Check the documentation:")
    print("   - README.md for overview")
    print("   - docs/architecture.md for system design")
    print("   - docs/user-guide.md for usage instructions")
    print()
    print("⚠️  Important Notes:")
    print("- This tool is for legitimate testing and research only")
    print("- Ensure compliance with applicable laws and terms of service")
    print("- Use responsibly and ethically")
    print()
    print("🆘 Need help?")
    print("- Check the documentation in the docs/ directory")
    print("- Review the examples in the examples/ directory")
    print("- Open an issue on GitHub for support")


def main():
    """Main setup function."""
    print_banner()
    
    # Check system requirements
    if not check_python_version():
        sys.exit(1)
    
    if not check_dependencies():
        sys.exit(1)
    
    # Install dependencies
    if not install_python_dependencies():
        sys.exit(1)
    
    if not install_node_dependencies():
        print("⚠️  Node.js dependencies installation failed, continuing...")
    
    # Setup system
    create_directories()
    
    if not setup_environment():
        sys.exit(1)
    
    setup_configuration()
    
    # Run tests
    if not run_tests():
        print("⚠️  Tests failed, but setup may still work")
    
    # Print next steps
    print_next_steps()


if __name__ == "__main__":
    main() 