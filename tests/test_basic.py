#!/usr/bin/env python3
"""
🧪 Basic Tests for TrafficFlou

This module contains basic tests to verify that the TrafficFlou system
components work correctly.

Author: TrafficFlou Team
Version: 1.0.0
"""

import pytest
import asyncio
import sys
from pathlib import Path

# Add the src directory to the Python path
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))


class TestTrafficFlouConfig:
    """Test configuration management."""
    
    def test_config_creation(self):
        """Test basic configuration creation."""
        from trafficflou import TrafficFlouConfig
        
        config = TrafficFlouConfig(
            target_url="https://example.com",
            traffic_volume=100,
            behavior_profile="organic"
        )
        
        assert config.target_url == "https://example.com"
        assert config.traffic_volume == 100
        assert config.behavior_profile == "organic"
    
    def test_config_validation(self):
        """Test configuration validation."""
        from trafficflou import TrafficFlouConfig, ConfigurationError
        
        # Test invalid URL
        with pytest.raises(ConfigurationError):
            TrafficFlouConfig(target_url="invalid-url")
        
        # Test negative traffic volume
        with pytest.raises(ConfigurationError):
            TrafficFlouConfig(
                target_url="https://example.com",
                traffic_volume=-1
            )


class TestTrafficFlouCore:
    """Test core TrafficFlou functionality."""
    
    @pytest.mark.asyncio
    async def test_traffic_flou_initialization(self):
        """Test TrafficFlou initialization."""
        from trafficflou import TrafficFlou
        
        flou = TrafficFlou(
            target_url="https://httpbin.org",
            traffic_volume=10,
            behavior_profile="organic"
        )
        
        assert flou.config.target_url == "https://httpbin.org"
        assert flou.config.traffic_volume == 10
        assert flou.config.behavior_profile == "organic"
    
    @pytest.mark.asyncio
    async def test_session_management(self):
        """Test session management."""
        from trafficflou import TrafficFlou
        
        flou = TrafficFlou(
            target_url="https://httpbin.org",
            traffic_volume=5,
            behavior_profile="organic"
        )
        
        # Start session
        session_id = await flou.start()
        assert session_id is not None
        assert session_id in flou.active_sessions
        
        # Stop session
        await flou.stop(session_id)
        assert session_id not in flou.active_sessions


class TestBehaviorSimulation:
    """Test behavior simulation."""
    
    def test_behavior_pattern_creation(self):
        """Test behavior pattern creation."""
        from trafficflou.traffic.behavior import BehaviorPattern, BehaviorType
        
        pattern = BehaviorPattern(
            behavior_type=BehaviorType.BROWSING,
            action="Page load and scan",
            parameters={"duration": 2.0},
            confidence=0.8
        )
        
        assert pattern.behavior_type == BehaviorType.BROWSING
        assert pattern.action == "Page load and scan"
        assert pattern.parameters["duration"] == 2.0
        assert pattern.confidence == 0.8
    
    @pytest.mark.asyncio
    async def test_behavior_simulator(self):
        """Test behavior simulator."""
        from trafficflou import TrafficFlouConfig
        from trafficflou.traffic.behavior import BehaviorSimulator
        
        config = TrafficFlouConfig(
            target_url="https://example.com",
            traffic_volume=10,
            behavior_profile="organic"
        )
        
        simulator = BehaviorSimulator(config)
        
        # Generate behavior patterns
        patterns = await simulator.generate_patterns("organic")
        
        assert "behavior_patterns" in patterns
        assert "user_profile" in patterns
        assert "session_duration" in patterns


class TestMetricsCollection:
    """Test metrics collection."""
    
    @pytest.mark.asyncio
    async def test_metrics_collector(self):
        """Test metrics collector."""
        from trafficflou import TrafficFlouConfig
        from trafficflou.analytics.metrics import MetricsCollector, RequestMetrics
        
        config = TrafficFlouConfig(
            target_url="https://example.com",
            traffic_volume=10,
            behavior_profile="organic"
        )
        
        collector = MetricsCollector(config)
        
        # Start session
        session_id = "test_session"
        await collector.start_session(session_id)
        
        # Record request
        request_metrics = RequestMetrics(
            request_id="test_request",
            session_id=session_id,
            url="https://example.com",
            method="GET",
            status_code=200,
            response_time=1.0,
            success=True,
            user_agent="test-agent"
        )
        
        await collector.record_request(request_metrics)
        
        # Get metrics
        metrics = collector.get_session_metrics(session_id)
        assert metrics is not None
        assert metrics.get("total_requests", 0) >= 1
        
        # Stop session
        await collector.stop_session(session_id)


class TestSecurityManager:
    """Test security manager."""
    
    def test_security_manager_initialization(self):
        """Test security manager initialization."""
        from trafficflou.utils.security import SecurityManager, SecurityConfig
        
        config = SecurityConfig(
            traffic_obfuscation=True,
            user_agent_randomization=True,
            rate_limiting=True
        )
        
        manager = SecurityManager(config)
        
        assert manager.config.traffic_obfuscation is True
        assert manager.config.user_agent_randomization is True
        assert manager.config.rate_limiting is True
    
    def test_user_agent_generation(self):
        """Test user agent generation."""
        from trafficflou.utils.security import SecurityManager, SecurityConfig
        
        config = SecurityConfig(user_agent_randomization=True)
        manager = SecurityManager(config)
        
        user_agent = manager.get_random_user_agent()
        assert user_agent is not None
        assert len(user_agent) > 0
    
    def test_rate_limiting(self):
        """Test rate limiting."""
        from trafficflou.utils.security import SecurityManager, SecurityConfig
        
        config = SecurityConfig(rate_limiting=True, max_requests_per_minute=5)
        manager = SecurityManager(config)
        
        # Test rate limiting
        for i in range(5):
            assert manager.check_rate_limit("test_identifier") is True
        
        # Should be rate limited after 5 requests
        assert manager.check_rate_limit("test_identifier") is False


class TestProxyManager:
    """Test proxy manager."""
    
    @pytest.mark.asyncio
    async def test_proxy_manager_initialization(self):
        """Test proxy manager initialization."""
        from trafficflou import TrafficFlouConfig
        from trafficflou.traffic.proxy_manager import ProxyManager
        
        config = TrafficFlouConfig(
            target_url="https://example.com",
            traffic_volume=10,
            behavior_profile="organic"
        )
        
        # Disable proxy for testing
        config.proxy.enabled = False
        
        manager = ProxyManager(config)
        await manager.initialize()
        
        # Get proxy pool (should be empty when disabled)
        proxy_pool = await manager.get_proxy_pool()
        assert len(proxy_pool) == 0


class TestAnalyticsDashboard:
    """Test analytics dashboard."""
    
    def test_dashboard_initialization(self):
        """Test dashboard initialization."""
        from trafficflou import TrafficFlouConfig
        from trafficflou.analytics.dashboard import AnalyticsDashboard
        
        config = TrafficFlouConfig(
            target_url="https://example.com",
            traffic_volume=10,
            behavior_profile="organic"
        )
        
        dashboard = AnalyticsDashboard(config)
        
        # Get dashboard data
        data = dashboard.get_dashboard_data()
        assert "system_overview" in data
        assert "performance_metrics" in data
        assert "ai_model_usage" in data


def test_imports():
    """Test that all modules can be imported."""
    try:
        from trafficflou import TrafficFlou, TrafficFlouConfig
        from trafficflou.core.exceptions import TrafficFlouError
        from trafficflou.ai_models.base import BaseAIModel
        from trafficflou.traffic.generator import TrafficGenerator
        from trafficflou.analytics.metrics import MetricsCollector
        from trafficflou.utils.logging import setup_logging
        from trafficflou.utils.security import SecurityManager
        assert True
    except ImportError as e:
        pytest.fail(f"Import failed: {e}")


if __name__ == "__main__":
    # Run basic tests
    pytest.main([__file__, "-v"]) 