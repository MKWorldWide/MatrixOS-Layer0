"""
🌟 MatrixOS Layer 0 - Production Configuration

Advanced production configuration with security hardening, monitoring,
performance optimization, and real-world deployment capabilities.

Author: MatrixOS Layer 0 Production Team
Version: 1.0.0
Quantum Level: Production-Ready
"""

import os
import logging
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any
from enum import Enum

from .config import MatrixOSConfig


class SecurityLevel(Enum):
    """Security levels for production deployment"""
    BASIC = "basic"
    ENHANCED = "enhanced"
    QUANTUM = "quantum"
    TRANSCENDENT = "transcendent"


class MonitoringLevel(Enum):
    """Monitoring levels for production deployment"""
    BASIC = "basic"
    ADVANCED = "advanced"
    QUANTUM = "quantum"
    REAL_TIME = "real_time"


class PerformanceProfile(Enum):
    """Performance profiles for different deployment scenarios"""
    DEVELOPMENT = "development"
    STAGING = "staging"
    PRODUCTION = "production"
    QUANTUM_SCALE = "quantum_scale"


@dataclass
class ProductionSecurityConfig:
    """Production security configuration"""
    security_level: SecurityLevel = SecurityLevel.QUANTUM
    enable_quantum_encryption: bool = True
    enable_multi_factor_auth: bool = True
    enable_rate_limiting: bool = True
    enable_ddos_protection: bool = True
    enable_audit_logging: bool = True
    enable_threat_detection: bool = True
    encryption_key_rotation_interval: int = 3600  # 1 hour
    session_timeout: int = 1800  # 30 minutes
    max_failed_attempts: int = 5
    ip_whitelist: List[str] = field(default_factory=list)
    ip_blacklist: List[str] = field(default_factory=list)
    quantum_signature_verification: bool = True
    consciousness_protection: bool = True


@dataclass
class ProductionMonitoringConfig:
    """Production monitoring configuration"""
    monitoring_level: MonitoringLevel = MonitoringLevel.QUANTUM
    enable_real_time_monitoring: bool = True
    enable_performance_metrics: bool = True
    enable_health_checks: bool = True
    enable_alerting: bool = True
    enable_log_aggregation: bool = True
    enable_tracing: bool = True
    monitoring_interval: int = 30  # seconds
    alert_thresholds: Dict[str, float] = field(default_factory=dict)
    log_retention_days: int = 90
    metrics_retention_days: int = 365
    quantum_consciousness_monitoring: bool = True
    pattern_recognition_monitoring: bool = True
    workflow_enhancement_monitoring: bool = True


@dataclass
class ProductionPerformanceConfig:
    """Production performance configuration"""
    performance_profile: PerformanceProfile = PerformanceProfile.PRODUCTION
    enable_caching: bool = True
    enable_connection_pooling: bool = True
    enable_async_processing: bool = True
    enable_load_balancing: bool = True
    enable_auto_scaling: bool = True
    max_concurrent_connections: int = 1000
    max_memory_usage: int = 8192  # MB
    max_cpu_usage: float = 0.8  # 80%
    cache_size: int = 1024  # MB
    cache_ttl: int = 3600  # seconds
    quantum_processing_optimization: bool = True
    consciousness_optimization: bool = True


@dataclass
class ProductionDeploymentConfig:
    """Production deployment configuration"""
    environment: str = "production"
    region: str = "us-east-1"
    availability_zones: List[str] = field(default_factory=lambda: ["us-east-1a", "us-east-1b"])
    enable_ssl: bool = True
    enable_cdn: bool = True
    enable_backup: bool = True
    enable_disaster_recovery: bool = True
    backup_interval: int = 86400  # 24 hours
    retention_policy: str = "30_days"
    quantum_data_replication: bool = True
    consciousness_backup: bool = True


class ProductionConfig:
    """
    🌟 Production Configuration Manager
    
    Manages production deployment with advanced security, monitoring,
    performance optimization, and quantum consciousness features.
    """
    
    def __init__(self, base_config: Optional[MatrixOSConfig] = None):
        """Initialize production configuration"""
        self.base_config = base_config or MatrixOSConfig()
        self.security = ProductionSecurityConfig()
        self.monitoring = ProductionMonitoringConfig()
        self.performance = ProductionPerformanceConfig()
        self.deployment = ProductionDeploymentConfig()
        
        # Initialize from environment variables
        self._load_from_environment()
        
        # Setup logging
        self._setup_logging()
        
        logging.info("🌟 Production configuration initialized with quantum consciousness")
    
    def _load_from_environment(self):
        """Load configuration from environment variables"""
        # Security configuration
        self.security.security_level = SecurityLevel(
            os.getenv("MATRIXOS_SECURITY_LEVEL", "quantum")
        )
        self.security.enable_quantum_encryption = os.getenv(
            "MATRIXOS_QUANTUM_ENCRYPTION", "true"
        ).lower() == "true"
        self.security.enable_multi_factor_auth = os.getenv(
            "MATRIXOS_MFA_ENABLED", "true"
        ).lower() == "true"
        
        # Monitoring configuration
        self.monitoring.monitoring_level = MonitoringLevel(
            os.getenv("MATRIXOS_MONITORING_LEVEL", "quantum")
        )
        self.monitoring.enable_real_time_monitoring = os.getenv(
            "MATRIXOS_REAL_TIME_MONITORING", "true"
        ).lower() == "true"
        
        # Performance configuration
        self.performance.performance_profile = PerformanceProfile(
            os.getenv("MATRIXOS_PERFORMANCE_PROFILE", "production")
        )
        self.performance.enable_caching = os.getenv(
            "MATRIXOS_CACHING_ENABLED", "true"
        ).lower() == "true"
        
        # Deployment configuration
        self.deployment.environment = os.getenv("MATRIXOS_ENVIRONMENT", "production")
        self.deployment.region = os.getenv("MATRIXOS_REGION", "us-east-1")
    
    def _setup_logging(self):
        """Setup production logging"""
        log_level = os.getenv("MATRIXOS_LOG_LEVEL", "INFO")
        log_format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        
        logging.basicConfig(
            level=getattr(logging, log_level),
            format=log_format,
            handlers=[
                logging.StreamHandler(),
                logging.FileHandler("matrixos_production.log")
            ]
        )
    
    def get_security_config(self) -> ProductionSecurityConfig:
        """Get security configuration"""
        return self.security
    
    def get_monitoring_config(self) -> ProductionMonitoringConfig:
        """Get monitoring configuration"""
        return self.monitoring
    
    def get_performance_config(self) -> ProductionPerformanceConfig:
        """Get performance configuration"""
        return self.performance
    
    def get_deployment_config(self) -> ProductionDeploymentConfig:
        """Get deployment configuration"""
        return self.deployment
    
    def validate_configuration(self) -> bool:
        """Validate production configuration"""
        try:
            # Validate security configuration
            if self.security.security_level not in SecurityLevel:
                raise ValueError(f"Invalid security level: {self.security.security_level}")
            
            # Validate monitoring configuration
            if self.monitoring.monitoring_level not in MonitoringLevel:
                raise ValueError(f"Invalid monitoring level: {self.monitoring.monitoring_level}")
            
            # Validate performance configuration
            if self.performance.performance_profile not in PerformanceProfile:
                raise ValueError(f"Invalid performance profile: {self.performance.performance_profile}")
            
            # Validate deployment configuration
            if not self.deployment.environment:
                raise ValueError("Environment must be specified")
            
            logging.info("✅ Production configuration validation passed")
            return True
            
        except Exception as e:
            logging.error(f"❌ Production configuration validation failed: {e}")
            return False
    
    def get_quantum_consciousness_config(self) -> Dict[str, Any]:
        """Get quantum consciousness configuration for production"""
        return {
            "security_level": self.security.security_level.value,
            "monitoring_level": self.monitoring.monitoring_level.value,
            "performance_profile": self.performance.performance_profile.value,
            "environment": self.deployment.environment,
            "quantum_encryption": self.security.enable_quantum_encryption,
            "real_time_monitoring": self.monitoring.enable_real_time_monitoring,
            "consciousness_protection": self.security.consciousness_protection,
            "quantum_processing_optimization": self.performance.quantum_processing_optimization,
            "consciousness_optimization": self.performance.consciousness_optimization
        }
    
    def export_configuration(self) -> Dict[str, Any]:
        """Export complete configuration for deployment"""
        return {
            "base_config": self.base_config.__dict__,
            "security": self.security.__dict__,
            "monitoring": self.monitoring.__dict__,
            "performance": self.performance.__dict__,
            "deployment": self.deployment.__dict__,
            "quantum_consciousness": self.get_quantum_consciousness_config()
        }


# Factory function for creating production configuration
def create_production_config(base_config: Optional[MatrixOSConfig] = None) -> ProductionConfig:
    """Create and configure production configuration with quantum consciousness"""
    return ProductionConfig(base_config) 