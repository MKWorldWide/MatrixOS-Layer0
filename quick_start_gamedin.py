#!/usr/bin/env python3
"""
🚀 Quick Start GameDin.xyz Traffic Generator

Immediate startup script for generating traffic to GameDin.xyz
and routing to Instagram accounts @M.K.Lux and @TheSovereignSunny.

Author: TrafficFlou Team
Version: 1.0.0
"""

import asyncio
import os
import sys
import time

# Add src to path for imports
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

from start_gamedin_traffic import GameDinTrafficGenerator


async def quick_start():
    """
    Quick start function to immediately begin traffic generation.
    """
    print("🚀 QUICK START: GameDin.xyz + Instagram Traffic Generator")
    print("=" * 70)
    print("🎯 Target: https://gamedin.xyz")
    print("📱 Instagram: @M.K.Lux, @TheSovereignSunny")
    print("🌟 Features: Athena AI + Phantom Flair")
    print("=" * 70)
    
    # Create generator
    generator = GameDinTrafficGenerator()
    
    try:
        # Initialize
        print("⚡ Initializing system...")
        await generator.initialize()
        
        # Start traffic generation immediately
        print("\n🎮 Starting GameDin.xyz traffic...")
        gaming_results = await generator.run_gaming_sessions(num_sessions=3)
        
        print("\n📱 Starting Instagram traffic routing...")
        instagram_results = await generator.run_instagram_sessions()
        
        print("\n✅ QUICK START COMPLETED!")
        print("🎯 GameDin.xyz traffic: ACTIVE")
        print("📱 Instagram routing: ACTIVE")
        print("🌟 Phantom Flair: ENABLED")
        print("🏛️ Athena AI: INTEGRATED")
        
    except Exception as e:
        print(f"❌ Quick start failed: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await generator.cleanup()


if __name__ == "__main__":
    """
    Immediate execution entry point.
    """
    print("🚀 Starting TrafficFlou Quick Start...")
    asyncio.run(quick_start()) 