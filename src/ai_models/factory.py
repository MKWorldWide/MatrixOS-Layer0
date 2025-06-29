"""
AI Model Factory - Abstract Factory Pattern Implementation

Quantum-detailed: Provides a standardized way to create and manage AI model instances
with consistent interfaces, error handling, and configuration management.

Features:
- Abstract Factory pattern for AI model creation
- Standardized configuration and initialization
- Error handling and validation
- Provider-specific optimizations
- Resource management and cleanup

Author: TrafficFlou Refactoring Team
Version: 2.0.0
License: Apache-2.0
"""

import asyncio
from abc import ABC, abstractmethod
from typing import Dict, Any, Optional, Type, Union
from enum import Enum
import structlog

from .base import BaseAIModel, ModelType, ModelResponse
from .openai_model import OpenAIModel
from .anthropic_model import AnthropicModel
from .athena_model import AthenaModel, AthenaConfig
from .primal_genesis_model import PrimalGenesisModel, PrimalGenesisConfig
from ..core.exceptions import AIModelError, ConfigurationError


class AIModelProvider(Enum):
    """Enumeration of supported AI model providers."""
    OPENAI = "openai"
    ANTHROPIC = "anthropic"
    ATHENA = "athena"
    PRIMAL_GENESIS = "primal_genesis"


class AIModelConfig:
    """
    Configuration class for AI model initialization.
    
    Quantum-detailed: Centralized configuration management for all AI models
    with validation, defaults, and provider-specific settings.
    """
    
    def __init__(
        self,
        provider: AIModelProvider,
        api_key: str,
        model_name: Optional[str] = None,
        **kwargs: Any
    ):
        """
        Initialize AI model configuration.
        
        Args:
            provider: AI model provider
            api_key: API key for the provider
            model_name: Specific model name (optional)
            **kwargs: Provider-specific configuration
        """
        self.provider = provider
        self.api_key = api_key
        self.model_name = model_name
        self.provider_config = kwargs
        
        # Validate configuration
        self._validate()
    
    def _validate(self) -> None:
        """Validate configuration parameters."""
        if not self.api_key:
            raise ConfigurationError(f"API key is required for {self.provider.value}")
        
        if self.provider == AIModelProvider.OPENAI and not self.model_name:
            self.model_name = "gpt-4"
        elif self.provider == AIModelProvider.ANTHROPIC and not self.model_name:
            self.model_name = "claude-3-sonnet-20240229"
        elif self.provider == AIModelProvider.ATHENA and not self.model_name:
            self.model_name = "athena-v1"
        elif self.provider == AIModelProvider.PRIMAL_GENESIS and not self.model_name:
            self.model_name = "primal-genesis-v2"


class AIModelFactory(ABC):
    """
    Abstract Factory for AI model creation.
    
    Quantum-detailed: Implements the Abstract Factory pattern to provide
    a consistent interface for creating AI model instances across different
    providers with standardized error handling and resource management.
    """
    
    def __init__(self):
        """Initialize the AI model factory."""
        self.logger = structlog.get_logger(__name__)
        self._models: Dict[str, BaseAIModel] = {}
        self._model_classes: Dict[AIModelProvider, Type[BaseAIModel]] = {
            AIModelProvider.OPENAI: OpenAIModel,
            AIModelProvider.ANTHROPIC: AnthropicModel,
            AIModelProvider.ATHENA: AthenaModel,
            AIModelProvider.PRIMAL_GENESIS: PrimalGenesisModel,
        }
    
    async def create_model(self, config: AIModelConfig) -> BaseAIModel:
        """
        Create an AI model instance.
        
        Args:
            config: AI model configuration
            
        Returns:
            Configured AI model instance
            
        Raises:
            AIModelError: If model creation fails
        """
        try:
            self.logger.info(
                "Creating AI model",
                provider=config.provider.value,
                model_name=config.model_name
            )
            
            # Check if model already exists
            model_key = f"{config.provider.value}:{config.model_name}"
            if model_key in self._models:
                self.logger.info("Reusing existing model instance", model_key=model_key)
                return self._models[model_key]
            
            # Get model class
            model_class = self._model_classes.get(config.provider)
            if not model_class:
                raise AIModelError(f"Unsupported provider: {config.provider.value}")
            
            # Create model instance
            model = await self._create_model_instance(model_class, config)
            
            # Store model instance
            self._models[model_key] = model
            
            self.logger.info(
                "AI model created successfully",
                provider=config.provider.value,
                model_name=config.model_name
            )
            
            return model
            
        except Exception as e:
            self.logger.error(
                "Failed to create AI model",
                provider=config.provider.value,
                error=str(e)
            )
            raise AIModelError(f"Failed to create {config.provider.value} model: {e}")
    
    @abstractmethod
    async def _create_model_instance(
        self, 
        model_class: Type[BaseAIModel], 
        config: AIModelConfig
    ) -> BaseAIModel:
        """
        Create a specific model instance.
        
        Args:
            model_class: Model class to instantiate
            config: Configuration for the model
            
        Returns:
            Model instance
        """
        pass
    
    async def get_model(self, provider: AIModelProvider, model_name: str) -> Optional[BaseAIModel]:
        """
        Get an existing model instance.
        
        Args:
            provider: AI model provider
            model_name: Model name
            
        Returns:
            Model instance if exists, None otherwise
        """
        model_key = f"{provider.value}:{model_name}"
        return self._models.get(model_key)
    
    async def remove_model(self, provider: AIModelProvider, model_name: str) -> bool:
        """
        Remove a model instance.
        
        Args:
            provider: AI model provider
            model_name: Model name
            
        Returns:
            True if removed, False if not found
        """
        model_key = f"{provider.value}:{model_name}"
        if model_key in self._models:
            model = self._models[model_key]
            await model.close()
            del self._models[model_key]
            self.logger.info("Model instance removed", model_key=model_key)
            return True
        return False
    
    async def close_all(self) -> None:
        """Close all model instances."""
        for model_key, model in self._models.items():
            try:
                await model.close()
                self.logger.info("Model instance closed", model_key=model_key)
            except Exception as e:
                self.logger.error("Failed to close model", model_key=model_key, error=str(e))
        
        self._models.clear()


class StandardAIModelFactory(AIModelFactory):
    """
    Standard implementation of AI model factory.
    
    Quantum-detailed: Provides concrete implementation for creating AI model
    instances with provider-specific initialization and configuration.
    """
    
    async def _create_model_instance(
        self, 
        model_class: Type[BaseAIModel], 
        config: AIModelConfig
    ) -> BaseAIModel:
        """
        Create a specific model instance with provider-specific configuration.
        
        Args:
            model_class: Model class to instantiate
            config: Configuration for the model
            
        Returns:
            Model instance
        """
        try:
            if config.provider == AIModelProvider.OPENAI:
                return model_class(
                    model_name=config.model_name,
                    api_key=config.api_key,
                    **config.provider_config
                )
            
            elif config.provider == AIModelProvider.ANTHROPIC:
                return model_class(
                    model_name=config.model_name,
                    api_key=config.api_key,
                    **config.provider_config
                )
            
            elif config.provider == AIModelProvider.ATHENA:
                athena_config = AthenaConfig(
                    athena_endpoint=config.provider_config.get("athena_endpoint"),
                    api_key=config.api_key,
                    model_version=config.provider_config.get("model_version", "v1"),
                    phantom_flair_enabled=config.provider_config.get("phantom_flair_enabled", True),
                    flair_intensity=config.provider_config.get("flair_intensity", 5)
                )
                return model_class(
                    model_name=config.model_name,
                    api_key=config.api_key,
                    config=athena_config
                )
            
            elif config.provider == AIModelProvider.PRIMAL_GENESIS:
                primal_config = PrimalGenesisConfig(
                    primary_provider=config.provider_config.get("primary_provider"),
                    mystical_mode=config.provider_config.get("mystical_mode"),
                    enable_phantom_analytics=config.provider_config.get("enable_phantom_analytics", True),
                    enable_shadow_tendrils=config.provider_config.get("enable_shadow_tendrils", True),
                    quantum_entropy_level=config.provider_config.get("quantum_entropy_level", 42),
                    ethereal_frequency=config.provider_config.get("ethereal_frequency", 144.000)
                )
                return model_class(config=primal_config)
            
            else:
                raise AIModelError(f"Unsupported provider: {config.provider.value}")
                
        except Exception as e:
            raise AIModelError(f"Failed to create {config.provider.value} model: {e}")


# Global factory instance
_ai_model_factory: Optional[StandardAIModelFactory] = None


def get_ai_model_factory() -> StandardAIModelFactory:
    """
    Get the global AI model factory instance.
    
    Returns:
        Global AI model factory instance
    """
    global _ai_model_factory
    if _ai_model_factory is None:
        _ai_model_factory = StandardAIModelFactory()
    return _ai_model_factory


async def create_ai_model(
    provider: Union[str, AIModelProvider],
    api_key: str,
    model_name: Optional[str] = None,
    **kwargs: Any
) -> BaseAIModel:
    """
    Convenience function to create an AI model.
    
    Args:
        provider: AI model provider (string or enum)
        api_key: API key for the provider
        model_name: Specific model name (optional)
        **kwargs: Provider-specific configuration
        
    Returns:
        Configured AI model instance
    """
    if isinstance(provider, str):
        provider = AIModelProvider(provider)
    
    config = AIModelConfig(provider, api_key, model_name, **kwargs)
    factory = get_ai_model_factory()
    return await factory.create_model(config)


async def close_all_models() -> None:
    """Close all AI model instances."""
    factory = get_ai_model_factory()
    await factory.close_all() 