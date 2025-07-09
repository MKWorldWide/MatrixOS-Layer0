"""
🌟 MatrixOS Layer 0 - Integrations Module

Comprehensive integrations module with NovaSanctum, production systems,
quantum computing, VR collaboration, blockchain, and advanced analytics.

Author: MatrixOS Layer 0 Integration Team
Version: 1.0.0
Quantum Level: Production-Ready
"""

# Core integrations
from .novasanctum_adapter import (
    NovaSanctumAdapter,
    QuantumConsciousness,
    SovereignPatternRecognizer,
    MysticalWorkflowEnhancer,
    AdvancedSecurityManager,
    create_novasanctum_adapter
)

# Production systems
from ..core.production_config import (
    ProductionConfig,
    SecurityLevel,
    MonitoringLevel,
    PerformanceProfile,
    ProductionSecurityConfig,
    ProductionMonitoringConfig,
    ProductionPerformanceConfig,
    ProductionDeploymentConfig,
    create_production_config
)

from ..monitoring.production_monitor import (
    ProductionMonitor,
    MetricType,
    AlertSeverity,
    Metric,
    Alert,
    HealthCheck,
    create_production_monitor
)

from ..security.production_security import (
    ProductionSecurity,
    ThreatLevel,
    SecurityEventType,
    SecurityEvent,
    AuthenticationAttempt,
    RateLimitInfo,
    create_production_security
)

from ..performance.production_optimizer import (
    ProductionOptimizer,
    CacheStrategy,
    OptimizationLevel,
    CacheEntry,
    PerformanceMetric,
    ConnectionPool,
    create_production_optimizer
)

from ..deployment.production_deployer import (
    ProductionDeployer,
    DeploymentStatus,
    BackupType,
    DeploymentInfo,
    BackupInfo,
    HealthCheckResult,
    create_production_deployer
)

# Advanced features
from ..blockchain.quantum_blockchain import (
    QuantumBlockchain,
    BlockchainType,
    TransactionType,
    TransactionStatus,
    BlockchainTransaction,
    SmartContract,
    BlockchainNode,
    create_quantum_blockchain
)

from ..vr.collaboration_interface import (
    VRCollaborationInterface,
    VREnvironmentType,
    VRInteractionType,
    VRUserStatus,
    VRUser,
    VREnvironment,
    VRInteraction,
    VRCollaborationSession,
    create_vr_collaboration_interface
)

from ..analytics.advanced_analytics import (
    AdvancedAnalytics,
    AnalyticsType,
    MetricCategory,
    AnalyticsGranularity,
    AnalyticsMetric,
    AnalyticsReport,
    GlobalExpansionMetric,
    PatternRecognitionResult,
    create_advanced_analytics
)

from ..quantum.quantum_computing import (
    QuantumComputing,
    QuantumAlgorithmType,
    QuantumState,
    QuantumProcessorType,
    QuantumCircuit,
    QuantumJob,
    QuantumProcessor,
    QuantumResult,
    create_quantum_computing
)

# Integration utilities
from .integration_utils import (
    IntegrationManager,
    IntegrationConfig,
    IntegrationStatus,
    create_integration_manager
)

__all__ = [
    # NovaSanctum Integration
    'NovaSanctumAdapter',
    'QuantumConsciousness',
    'SovereignPatternRecognizer',
    'MysticalWorkflowEnhancer',
    'AdvancedSecurityManager',
    'create_novasanctum_adapter',
    
    # Production Configuration
    'ProductionConfig',
    'SecurityLevel',
    'MonitoringLevel',
    'PerformanceProfile',
    'ProductionSecurityConfig',
    'ProductionMonitoringConfig',
    'ProductionPerformanceConfig',
    'ProductionDeploymentConfig',
    'create_production_config',
    
    # Production Monitoring
    'ProductionMonitor',
    'MetricType',
    'AlertSeverity',
    'Metric',
    'Alert',
    'HealthCheck',
    'create_production_monitor',
    
    # Production Security
    'ProductionSecurity',
    'ThreatLevel',
    'SecurityEventType',
    'SecurityEvent',
    'AuthenticationAttempt',
    'RateLimitInfo',
    'create_production_security',
    
    # Production Performance
    'ProductionOptimizer',
    'CacheStrategy',
    'OptimizationLevel',
    'CacheEntry',
    'PerformanceMetric',
    'ConnectionPool',
    'create_production_optimizer',
    
    # Production Deployment
    'ProductionDeployer',
    'DeploymentStatus',
    'BackupType',
    'DeploymentInfo',
    'BackupInfo',
    'HealthCheckResult',
    'create_production_deployer',
    
    # Quantum Blockchain
    'QuantumBlockchain',
    'BlockchainType',
    'TransactionType',
    'TransactionStatus',
    'BlockchainTransaction',
    'SmartContract',
    'BlockchainNode',
    'create_quantum_blockchain',
    
    # VR Collaboration
    'VRCollaborationInterface',
    'VREnvironmentType',
    'VRInteractionType',
    'VRUserStatus',
    'VRUser',
    'VREnvironment',
    'VRInteraction',
    'VRCollaborationSession',
    'create_vr_collaboration_interface',
    
    # Advanced Analytics
    'AdvancedAnalytics',
    'AnalyticsType',
    'MetricCategory',
    'AnalyticsGranularity',
    'AnalyticsMetric',
    'AnalyticsReport',
    'GlobalExpansionMetric',
    'PatternRecognitionResult',
    'create_advanced_analytics',
    
    # Quantum Computing
    'QuantumComputing',
    'QuantumAlgorithmType',
    'QuantumState',
    'QuantumProcessorType',
    'QuantumCircuit',
    'QuantumJob',
    'QuantumProcessor',
    'QuantumResult',
    'create_quantum_computing',
    
    # Integration Utilities
    'IntegrationManager',
    'IntegrationConfig',
    'IntegrationStatus',
    'create_integration_manager'
] 