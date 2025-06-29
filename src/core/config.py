"""
⚙️ Configuration Management

Centralized configuration management for the TrafficFlou system,
including Athena AI model and Phantom Flair settings.

Author: TrafficFlou Team
Version: 1.0.0
"""

import os
from typing import Dict, List, Any, Optional, Union
from dataclasses import dataclass, field

from pydantic import BaseModel, Field, validator
from pydantic.env_settings import BaseSettings


class AIModelConfig(BaseModel):
    """Base configuration for AI models."""
    
    model_name: str = Field(default="gpt-4", description="AI model name")
    api_key: str = Field(default="", description="API key for the model")
    max_tokens: int = Field(default=1000, description="Maximum tokens for responses")
    temperature: float = Field(default=0.7, description="Temperature for generation")
    timeout: int = Field(default=30, description="Request timeout in seconds")
    max_retries: int = Field(default=3, description="Maximum retry attempts")
    retry_delay: float = Field(default=1.0, description="Delay between retries")
    confidence_threshold: float = Field(default=0.7, description="Minimum confidence threshold")


class TrafficConfig(BaseModel):
    """Configuration for traffic generation."""
    
    request_timeout: int = Field(default=30, description="HTTP request timeout")
    max_concurrent_requests: int = Field(default=10, description="Maximum concurrent requests")
    user_agent_rotation: bool = Field(default=True, description="Enable user agent rotation")
    proxy_enabled: bool = Field(default=False, description="Enable proxy support")
    proxy_list: List[str] = Field(default_factory=list, description="List of proxy servers")
    request_delay: float = Field(default=1.0, description="Delay between requests")
    max_requests_per_session: int = Field(default=50, description="Maximum requests per session")


class BehaviorConfig(BaseModel):
    """Configuration for behavior simulation."""
    
    behavior_types: List[str] = Field(
        default_factory=lambda: ["browsing", "clicking", "scrolling", "form_filling"],
        description="Available behavior types"
    )
    user_profiles: List[str] = Field(
        default_factory=lambda: ["casual", "focused", "researcher", "shopper"],
        description="Available user profile types"
    )
    interaction_patterns: Dict[str, Any] = Field(
        default_factory=dict,
        description="Interaction pattern configurations"
    )
    realism_level: int = Field(default=3, description="Realism level (1-5)")
    randomization_factor: float = Field(default=0.3, description="Randomization factor")


class PhantomFlairConfig(BaseModel):
    """Configuration for Phantom Flair capabilities."""
    
    enabled: bool = Field(default=True, description="Enable Phantom Flair")
    intensity: float = Field(default=0.7, description="Phantom Flair intensity (0.0-1.0)")
    sophistication_level: int = Field(default=3, description="Sophistication level (1-5)")
    
    # Flair patterns
    patterns: List[str] = Field(
        default_factory=lambda: [
            "organic_browsing", "social_engagement", "ecommerce_exploration",
            "content_consumption", "research_patterns", "casual_navigation",
            "phantom_navigation", "flair_interaction", "athena_insight"
        ],
        description="Available Phantom Flair patterns"
    )
    
    # Timing and pacing
    min_delay: float = Field(default=0.5, description="Minimum delay between interactions")
    max_delay: float = Field(default=3.0, description="Maximum delay between interactions")
    natural_pacing: bool = Field(default=True, description="Enable natural pacing")
    context_aware_timing: bool = Field(default=True, description="Enable context-aware timing")
    
    # Interaction sophistication
    hover_effects: bool = Field(default=True, description="Enable hover effects")
    scroll_behavior: bool = Field(default=True, description="Enable scroll behavior")
    click_patterns: bool = Field(default=True, description="Enable click patterns")
    form_interactions: bool = Field(default=True, description="Enable form interactions")
    
    # Adaptive learning
    learning_enabled: bool = Field(default=True, description="Enable adaptive learning")
    pattern_adaptation: bool = Field(default=True, description="Enable pattern adaptation")
    context_memory: bool = Field(default=True, description="Enable context memory")
    
    # Phantom Flair specific
    flair_randomization: bool = Field(default=True, description="Enable flair randomization")
    intensity_variation: float = Field(default=0.2, description="Intensity variation factor")
    pattern_evolution: bool = Field(default=True, description="Enable pattern evolution")


class AnalyticsConfig(BaseModel):
    """Configuration for analytics and metrics."""
    
    enabled: bool = Field(default=True, description="Enable analytics")
    storage_backend: str = Field(default="memory", description="Storage backend type")
    metrics_interval: int = Field(default=60, description="Metrics collection interval")
    retention_period: int = Field(default=86400, description="Data retention period")
    real_time_monitoring: bool = Field(default=True, description="Enable real-time monitoring")


class SecurityConfig(BaseModel):
    """Configuration for security and privacy."""
    
    traffic_obfuscation: bool = Field(default=True, description="Enable traffic obfuscation")
    user_agent_randomization: bool = Field(default=True, description="Enable user agent randomization")
    privacy_protection: bool = Field(default=True, description="Enable privacy protection")
    request_encryption: bool = Field(default=False, description="Enable request encryption")
    fingerprint_protection: bool = Field(default=True, description="Enable fingerprint protection")


class TrafficFlouConfig(BaseSettings):
    """
    🚀 TrafficFlou System Configuration
    
    Comprehensive configuration for the TrafficFlou system, including
    Athena AI model integration and Phantom Flair capabilities.
    
    Environment Variables:
    - TRAFFICFLOU_LOG_LEVEL: Logging level
    - TRAFFICFLOU_OPENAI_API_KEY: OpenAI API key
    - TRAFFICFLOU_ANTHROPIC_API_KEY: Anthropic API key
    - TRAFFICFLOU_ATHENA_API_KEY: Athena API key
    - TRAFFICFLOU_ATHENA_ENDPOINT: Athena API endpoint
    - TRAFFICFLOU_PHANTOM_FLAIR_ENABLED: Enable Phantom Flair
    - TRAFFICFLOU_PHANTOM_FLAIR_INTENSITY: Phantom Flair intensity
    """
    
    # Core system settings
    log_level: str = Field(default="INFO", description="Logging level")
    debug_mode: bool = Field(default=False, description="Enable debug mode")
    
    # Default target configuration
    default_target_url: str = Field(default="https://gamedin.xyz", description="Default target website")
    default_session_duration: int = Field(default=600, description="Default session duration in seconds")
    default_traffic_volume: int = Field(default=100, description="Default traffic volume per session")
    
    # Instagram routing configuration
    instagram_routing_enabled: bool = Field(default=True, description="Enable Instagram traffic routing")
    instagram_targets: List[str] = Field(
        default_factory=lambda: ["@M.K.Lux", "@TheSovereignSunny"],
        description="Instagram accounts to route traffic to"
    )
    instagram_routing_ratio: float = Field(default=0.3, description="Ratio of traffic to route to Instagram")
    instagram_session_duration: int = Field(default=300, description="Instagram session duration in seconds")
    instagram_traffic_volume: int = Field(default=50, description="Instagram traffic volume per session")
    
    # AI Model configurations
    openai_api_key: str = Field(default="", description="OpenAI API key")
    openai_model_name: str = Field(default="gpt-4", description="OpenAI model name")
    openai_config: AIModelConfig = Field(default_factory=AIModelConfig, description="OpenAI configuration")
    
    anthropic_api_key: str = Field(default="", description="Anthropic API key")
    anthropic_model_name: str = Field(default="claude-3-sonnet", description="Anthropic model name")
    anthropic_config: AIModelConfig = Field(default_factory=AIModelConfig, description="Anthropic configuration")
    
    # Athena AI Model configuration
    athena_api_key: str = Field(default="", description="Athena API key")
    athena_model_name: str = Field(default="athena-v2.0", description="Athena model name")
    athena_endpoint: str = Field(default="https://api.athena.ai/v1", description="Athena API endpoint")
    athena_model_version: str = Field(default="athena-v2.0", description="Athena model version")
    athena_config: AIModelConfig = Field(default_factory=AIModelConfig, description="Athena configuration")
    
    # Phantom Flair configuration
    phantom_flair_enabled: bool = Field(default=True, description="Enable Phantom Flair capabilities")
    phantom_flair_intensity: float = Field(default=0.8, description="Phantom Flair intensity")
    phantom_flair_sophistication: int = Field(default=4, description="Phantom Flair sophistication level")
    phantom_flair_patterns: List[str] = Field(
        default_factory=lambda: [
            "organic_browsing", "social_engagement", "ecommerce_exploration",
            "content_consumption", "research_patterns", "casual_navigation",
            "phantom_navigation", "flair_interaction", "athena_insight"
        ],
        description="Phantom Flair patterns"
    )
    phantom_flair_learning: bool = Field(default=True, description="Enable Phantom Flair learning")
    phantom_flair_adaptation: bool = Field(default=True, description="Enable Phantom Flair adaptation")
    phantom_flair_config: PhantomFlairConfig = Field(
        default_factory=PhantomFlairConfig,
        description="Phantom Flair configuration"
    )
    
    # Component configurations
    traffic_config: TrafficConfig = Field(default_factory=TrafficConfig, description="Traffic generation configuration")
    behavior_config: BehaviorConfig = Field(default_factory=BehaviorConfig, description="Behavior simulation configuration")
    analytics_config: AnalyticsConfig = Field(default_factory=AnalyticsConfig, description="Analytics configuration")
    security_config: SecurityConfig = Field(default_factory=SecurityConfig, description="Security configuration")
    
    # Session management
    max_concurrent_sessions: int = Field(default=15, description="Maximum concurrent sessions")
    session_timeout: int = Field(default=3600, description="Session timeout in seconds")
    
    # Performance settings
    max_workers: int = Field(default=6, description="Maximum worker threads")
    request_rate_limit: int = Field(default=200, description="Request rate limit per minute")
    memory_limit: int = Field(default=2048, description="Memory limit in MB")
    
    # Advanced settings
    enable_metrics: bool = Field(default=True, description="Enable metrics collection")
    enable_logging: bool = Field(default=True, description="Enable structured logging")
    enable_security: bool = Field(default=True, description="Enable security features")
    
    # Gaming-specific settings
    gaming_mode_enabled: bool = Field(default=True, description="Enable gaming-optimized settings")
    gaming_user_profiles: List[str] = Field(
        default_factory=lambda: ["gamer", "casual_player", "competitive_player", "streamer"],
        description="Gaming-specific user profiles"
    )
    gaming_behavior_patterns: List[str] = Field(
        default_factory=lambda: ["game_browsing", "community_engagement", "tournament_research", "stream_watching"],
        description="Gaming-specific behavior patterns"
    )
    
    class Config:
        env_prefix = "TRAFFICFLOU_"
        case_sensitive = False
    
    @validator('phantom_flair_intensity')
    def validate_phantom_flair_intensity(cls, v):
        """Validate Phantom Flair intensity."""
        if not 0.0 <= v <= 1.0:
            raise ValueError('Phantom Flair intensity must be between 0.0 and 1.0')
        return v
    
    @validator('phantom_flair_sophistication')
    def validate_phantom_flair_sophistication(cls, v):
        """Validate Phantom Flair sophistication level."""
        if not 1 <= v <= 5:
            raise ValueError('Phantom Flair sophistication must be between 1 and 5')
        return v
    
    @validator('log_level')
    def validate_log_level(cls, v):
        """Validate log level."""
        valid_levels = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
        if v.upper() not in valid_levels:
            raise ValueError(f'Log level must be one of: {valid_levels}')
        return v.upper()
    
    def get_ai_model_config(self, model_name: str) -> AIModelConfig:
        """
        Get configuration for a specific AI model.
        
        Args:
            model_name (str): Name of the AI model
            
        Returns:
            AIModelConfig: Model-specific configuration
        """
        if model_name.lower() == "openai":
            return self.openai_config
        elif model_name.lower() == "anthropic":
            return self.anthropic_config
        elif model_name.lower() == "athena":
            return self.athena_config
        else:
            return AIModelConfig()
    
    def is_phantom_flair_enabled(self) -> bool:
        """Check if Phantom Flair is enabled."""
        return self.phantom_flair_enabled and self.athena_api_key
    
    def get_phantom_flair_config(self) -> PhantomFlairConfig:
        """Get Phantom Flair configuration."""
        config = self.phantom_flair_config.copy()
        config.enabled = self.phantom_flair_enabled
        config.intensity = self.phantom_flair_intensity
        config.sophistication_level = self.phantom_flair_sophistication
        config.patterns = self.phantom_flair_patterns
        config.learning_enabled = self.phantom_flair_learning
        config.pattern_adaptation = self.phantom_flair_adaptation
        return config
    
    def validate_configuration(self) -> List[str]:
        """
        Validate the configuration and return any errors.
        
        Returns:
            List[str]: List of validation errors
        """
        errors = []
        
        # Check for at least one AI model
        if not any([self.openai_api_key, self.anthropic_api_key, self.athena_api_key]):
            errors.append("At least one AI model API key must be configured")
        
        # Check Phantom Flair requirements
        if self.phantom_flair_enabled and not self.athena_api_key:
            errors.append("Athena API key required for Phantom Flair capabilities")
        
        # Check session limits
        if self.max_concurrent_sessions <= 0:
            errors.append("Maximum concurrent sessions must be greater than 0")
        
        if self.session_timeout <= 0:
            errors.append("Session timeout must be greater than 0")
        
        # Check performance limits
        if self.max_workers <= 0:
            errors.append("Maximum workers must be greater than 0")
        
        if self.request_rate_limit <= 0:
            errors.append("Request rate limit must be greater than 0")
        
        return errors
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert configuration to dictionary."""
        return {
            "log_level": self.log_level,
            "debug_mode": self.debug_mode,
            "default_target_url": self.default_target_url,
            "phantom_flair_enabled": self.phantom_flair_enabled,
            "phantom_flair_intensity": self.phantom_flair_intensity,
            "phantom_flair_sophistication": self.phantom_flair_sophistication,
            "max_concurrent_sessions": self.max_concurrent_sessions,
            "session_timeout": self.session_timeout,
            "default_session_duration": self.default_session_duration,
            "max_workers": self.max_workers,
            "request_rate_limit": self.request_rate_limit,
            "enable_metrics": self.enable_metrics,
            "enable_logging": self.enable_logging,
            "enable_security": self.enable_security,
            "gaming_mode_enabled": self.gaming_mode_enabled,
            "ai_models_configured": {
                "openai": bool(self.openai_api_key),
                "anthropic": bool(self.anthropic_api_key),
                "athena": bool(self.athena_api_key)
            }
        }


def load_config_from_env() -> TrafficFlouConfig:
    """
    Load configuration from environment variables.
    
    Returns:
        TrafficFlouConfig: Loaded configuration
    """
    return TrafficFlouConfig()


def load_config_from_file(config_path: str) -> TrafficFlouConfig:
    """
    Load configuration from file.
    
    Args:
        config_path (str): Path to configuration file
        
    Returns:
        TrafficFlouConfig: Loaded configuration
    """
    # This would implement file-based configuration loading
    # For now, return environment-based configuration
    return load_config_from_env()


def validate_and_load_config(config_source: str = "env") -> TrafficFlouConfig:
    """
    Validate and load configuration.
    
    Args:
        config_source (str): Configuration source ("env" or file path)
        
    Returns:
        TrafficFlouConfig: Validated configuration
        
    Raises:
        ValueError: If configuration is invalid
    """
    if config_source == "env":
        config = load_config_from_env()
    else:
        config = load_config_from_file(config_source)
    
    # Validate configuration
    errors = config.validate_configuration()
    if errors:
        raise ValueError(f"Configuration validation failed: {'; '.join(errors)}")
    
    return config 