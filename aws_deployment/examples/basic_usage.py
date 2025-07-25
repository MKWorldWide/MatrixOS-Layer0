#!/usr/bin/env python3
"""
🚦 TrafficFlou Basic Usage Example

This example demonstrates how to use the TrafficFlou system for basic
traffic generation and redirection to a target website.

Author: TrafficFlou Team
Version: 1.0.0
"""

import asyncio
import time
from pathlib import Path
import sys

# Add the src directory to the Python path
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from trafficflou import TrafficFlou, TrafficFlouConfig


async def basic_traffic_example():
    """
    Basic example of using TrafficFlou for traffic generation.
    
    This example demonstrates:
    - Initializing the TrafficFlou system
    - Starting a traffic generation session
    - Monitoring analytics
    - Graceful shutdown
    """
    
    print("🚦 TrafficFlou Basic Usage Example")
    print("=" * 50)
    
    # Configuration for the example
    config = {
        "target_url": "https://httpbin.org",  # Safe test URL
        "traffic_volume": 10,  # Small volume for testing
        "behavior_profile": "organic",
        "ai_models": {
            "openai": {
                "enabled": False,  # Disable AI for basic example
                "api_key": "dummy_key"
            },
            "anthropic": {
                "enabled": False,  # Disable AI for basic example
                "api_key": "dummy_key"
            },
            "fallback_enabled": True
        },
        "traffic": {
            "concurrent_requests": 2,
            "request_delay": 0.5,
            "timeout": 10
        },
        "analytics": {
            "enabled": True,
            "storage_backend": "memory"
        }
    }
    
    try:
        # Initialize TrafficFlou
        print("📋 Initializing TrafficFlou system...")
        flou = TrafficFlou(
            target_url=config["target_url"],
            traffic_volume=config["traffic_volume"],
            behavior_profile=config["behavior_profile"]
        )
        
        print(f"✅ TrafficFlou initialized successfully")
        print(f"🎯 Target URL: {config['target_url']}")
        print(f"📊 Traffic Volume: {config['traffic_volume']} requests")
        print(f"🎭 Behavior Profile: {config['behavior_profile']}")
        print()
        
        # Start traffic generation session
        print("🚀 Starting traffic generation session...")
        session_id = await flou.start()
        print(f"✅ Session started with ID: {session_id}")
        print()
        
        # Monitor progress
        print("📈 Monitoring traffic generation...")
        for i in range(5):  # Monitor for 5 intervals
            await asyncio.sleep(2)  # Wait 2 seconds
            
            # Get analytics
            analytics = flou.get_analytics(session_id)
            if analytics:
                print(f"⏱️  Progress update {i+1}/5:")
                print(f"   📊 Total requests: {analytics.get('total_requests', 0)}")
                print(f"   ✅ Successful: {analytics.get('successful_requests', 0)}")
                print(f"   ❌ Failed: {analytics.get('failed_requests', 0)}")
                print(f"   ⚡ Success rate: {analytics.get('success_rate', 0):.2%}")
                print()
        
        # Get final analytics
        print("📊 Final Analytics:")
        final_analytics = flou.get_analytics(session_id)
        if final_analytics:
            print(f"   📈 Total requests: {final_analytics.get('total_requests', 0)}")
            print(f"   ✅ Successful requests: {final_analytics.get('successful_requests', 0)}")
            print(f"   ❌ Failed requests: {final_analytics.get('failed_requests', 0)}")
            print(f"   ⚡ Success rate: {final_analytics.get('success_rate', 0):.2%}")
            print(f"   🕐 Average response time: {final_analytics.get('average_response_time', 0):.2f}s")
        
        # Stop the session
        print("\n🛑 Stopping traffic generation session...")
        await flou.stop(session_id)
        print("✅ Session stopped successfully")
        
    except Exception as e:
        print(f"❌ Error during traffic generation: {e}")
        return False
    
    return True


async def advanced_traffic_example():
    """
    Advanced example with AI-powered behavior generation.
    
    This example demonstrates:
    - Using AI models for intelligent behavior generation
    - Custom behavior profiles
    - Real-time analytics monitoring
    - Session management
    """
    
    print("\n🚀 TrafficFlou Advanced Usage Example")
    print("=" * 50)
    
    # Note: This example requires valid API keys
    print("⚠️  Note: This example requires valid OpenAI or Anthropic API keys")
    print("   Set your API keys in the environment variables:")
    print("   - OPENAI_API_KEY")
    print("   - ANTHROPIC_API_KEY")
    print()
    
    # Check for API keys
    import os
    openai_key = os.getenv("OPENAI_API_KEY")
    anthropic_key = os.getenv("ANTHROPIC_API_KEY")
    
    if not openai_key and not anthropic_key:
        print("❌ No API keys found. Skipping advanced example.")
        print("   Set OPENAI_API_KEY or ANTHROPIC_API_KEY to run this example.")
        return False
    
    try:
        # Initialize with AI models
        print("🤖 Initializing TrafficFlou with AI models...")
        
        # Configuration for AI-powered traffic
        config = {
            "target_url": "https://httpbin.org",
            "traffic_volume": 5,  # Small volume for testing
            "behavior_profile": "shopping",  # E-commerce behavior
            "ai_models": {
                "openai": {
                    "enabled": bool(openai_key),
                    "api_key": openai_key or "dummy"
                },
                "anthropic": {
                    "enabled": bool(anthropic_key),
                    "api_key": anthropic_key or "dummy"
                },
                "fallback_enabled": True
            },
            "traffic": {
                "concurrent_requests": 1,
                "request_delay": 1.0,
                "timeout": 15
            },
            "behavior": {
                "profile": "shopping",
                "session_duration": 120,
                "page_views_per_session": 3
            }
        }
        
        flou = TrafficFlou(
            target_url=config["target_url"],
            traffic_volume=config["traffic_volume"],
            behavior_profile=config["behavior_profile"]
        )
        
        print("✅ AI-powered TrafficFlou initialized")
        print(f"🎯 Target URL: {config['target_url']}")
        print(f"🤖 AI Models: {list(flou.ai_models.keys())}")
        print()
        
        # Use context manager for automatic session management
        print("🔄 Starting AI-powered traffic generation...")
        async with flou.session("advanced_example") as session_id:
            print(f"✅ Session started: {session_id}")
            
            # Monitor in real-time
            for i in range(3):
                await asyncio.sleep(3)
                
                analytics = flou.get_analytics(session_id)
                if analytics:
                    print(f"📊 Update {i+1}/3:")
                    print(f"   🎭 AI behaviors generated: {len(analytics.get('ai_model_usage', {}))}")
                    print(f"   📈 Success rate: {analytics.get('success_rate', 0):.2%}")
                    print(f"   ⚡ Avg response time: {analytics.get('average_response_time', 0):.2f}s")
        
        print("✅ Advanced example completed successfully")
        
    except Exception as e:
        print(f"❌ Error in advanced example: {e}")
        return False
    
    return True


async def main():
    """Main function to run all examples."""
    
    print("🚦 TrafficFlou Examples")
    print("=" * 60)
    print()
    
    # Run basic example
    success = await basic_traffic_example()
    
    if success:
        # Run advanced example
        await advanced_traffic_example()
    
    print("\n" + "=" * 60)
    print("🎉 Examples completed!")
    print("\n📚 Next steps:")
    print("   1. Review the generated logs")
    print("   2. Check the analytics dashboard")
    print("   3. Customize configuration for your needs")
    print("   4. Set up your API keys for AI-powered features")
    print("\n📖 For more information, see the documentation:")
    print("   - README.md")
    print("   - docs/user-guide.md")
    print("   - docs/api-reference.md")


if __name__ == "__main__":
    # Run the examples
    asyncio.run(main()) 