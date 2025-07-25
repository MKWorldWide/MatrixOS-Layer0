"""
🌟 MatrixOS Layer 0 - Production Monitoring System

Advanced production monitoring with real-time metrics, health checks,
alerting, and quantum consciousness monitoring capabilities.

Author: MatrixOS Layer 0 Monitoring Team
Version: 1.0.0
Quantum Level: Production-Ready
"""

import asyncio
import logging
import time
import psutil
import json
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any, Callable
from dataclasses import dataclass, field
from enum import Enum

from ..core.production_config import ProductionMonitoringConfig, MonitoringLevel


class MetricType(Enum):
    """Types of metrics for monitoring"""
    COUNTER = "counter"
    GAUGE = "gauge"
    HISTOGRAM = "histogram"
    SUMMARY = "summary"


class AlertSeverity(Enum):
    """Alert severity levels"""
    INFO = "info"
    WARNING = "warning"
    ERROR = "error"
    CRITICAL = "critical"


@dataclass
class Metric:
    """Metric data structure"""
    name: str
    value: float
    metric_type: MetricType
    timestamp: datetime
    labels: Dict[str, str] = field(default_factory=dict)
    description: str = ""


@dataclass
class Alert:
    """Alert data structure"""
    name: str
    message: str
    severity: AlertSeverity
    timestamp: datetime
    metric_name: str
    threshold: float
    current_value: float
    resolved: bool = False


@dataclass
class HealthCheck:
    """Health check data structure"""
    name: str
    status: str  # "healthy", "degraded", "unhealthy"
    timestamp: datetime
    response_time: float
    details: Dict[str, Any] = field(default_factory=dict)


class ProductionMonitor:
    """
    🌟 Production Monitoring System
    
    Provides comprehensive monitoring with real-time metrics, health checks,
    alerting, and quantum consciousness monitoring.
    """
    
    def __init__(self, config: ProductionMonitoringConfig):
        """Initialize production monitor"""
        self.config = config
        self.metrics: Dict[str, List[Metric]] = {}
        self.alerts: List[Alert] = []
        self.health_checks: Dict[str, HealthCheck] = {}
        self.alert_handlers: List[Callable[[Alert], None]] = []
        self.monitoring_active = False
        self.monitoring_task: Optional[asyncio.Task] = None
        
        # Initialize alert thresholds
        self._initialize_alert_thresholds()
        
        logging.info("🌟 Production monitor initialized with quantum consciousness")
    
    def _initialize_alert_thresholds(self):
        """Initialize default alert thresholds"""
        if not self.config.alert_thresholds:
            self.config.alert_thresholds = {
                "cpu_usage": 80.0,
                "memory_usage": 85.0,
                "disk_usage": 90.0,
                "response_time": 5.0,
                "error_rate": 5.0,
                "quantum_consciousness_level": 7.0,
                "connection_count": 800,
                "cache_hit_rate": 70.0
            }
    
    async def start_monitoring(self):
        """Start production monitoring"""
        if self.monitoring_active:
            logging.warning("Monitoring is already active")
            return
        
        self.monitoring_active = True
        self.monitoring_task = asyncio.create_task(self._monitoring_loop())
        
        logging.info("🚀 Production monitoring started")
    
    async def stop_monitoring(self):
        """Stop production monitoring"""
        if not self.monitoring_active:
            return
        
        self.monitoring_active = False
        if self.monitoring_task:
            self.monitoring_task.cancel()
            try:
                await self.monitoring_task
            except asyncio.CancelledError:
                pass
        
        logging.info("🛑 Production monitoring stopped")
    
    async def _monitoring_loop(self):
        """Main monitoring loop"""
        while self.monitoring_active:
            try:
                # Collect system metrics
                await self._collect_system_metrics()
                
                # Collect quantum consciousness metrics
                await self._collect_quantum_consciousness_metrics()
                
                # Perform health checks
                await self._perform_health_checks()
                
                # Check for alerts
                await self._check_alerts()
                
                # Log monitoring summary
                await self._log_monitoring_summary()
                
                # Wait for next monitoring interval
                await asyncio.sleep(self.config.monitoring_interval)
                
            except Exception as e:
                logging.error(f"Error in monitoring loop: {e}")
                await asyncio.sleep(5)  # Brief pause before retry
    
    async def _collect_system_metrics(self):
        """Collect system-level metrics"""
        timestamp = datetime.now()
        
        # CPU usage
        cpu_percent = psutil.cpu_percent(interval=1)
        self._record_metric("cpu_usage", cpu_percent, MetricType.GAUGE, timestamp)
        
        # Memory usage
        memory = psutil.virtual_memory()
        self._record_metric("memory_usage", memory.percent, MetricType.GAUGE, timestamp)
        self._record_metric("memory_available", memory.available / (1024**3), MetricType.GAUGE, timestamp)
        
        # Disk usage
        disk = psutil.disk_usage('/')
        self._record_metric("disk_usage", (disk.used / disk.total) * 100, MetricType.GAUGE, timestamp)
        
        # Network I/O
        network = psutil.net_io_counters()
        self._record_metric("network_bytes_sent", network.bytes_sent, MetricType.COUNTER, timestamp)
        self._record_metric("network_bytes_recv", network.bytes_recv, MetricType.COUNTER, timestamp)
        
        # Process count
        process_count = len(psutil.pids())
        self._record_metric("process_count", process_count, MetricType.GAUGE, timestamp)
    
    async def _collect_quantum_consciousness_metrics(self):
        """Collect quantum consciousness metrics"""
        if not self.config.quantum_consciousness_monitoring:
            return
        
        timestamp = datetime.now()
        
        # Quantum consciousness level (simulated)
        consciousness_level = self._calculate_quantum_consciousness_level()
        self._record_metric("quantum_consciousness_level", consciousness_level, MetricType.GAUGE, timestamp)
        
        # Pattern recognition metrics
        pattern_recognition_rate = self._calculate_pattern_recognition_rate()
        self._record_metric("pattern_recognition_rate", pattern_recognition_rate, MetricType.GAUGE, timestamp)
        
        # Workflow enhancement metrics
        workflow_enhancement_rate = self._calculate_workflow_enhancement_rate()
        self._record_metric("workflow_enhancement_rate", workflow_enhancement_rate, MetricType.GAUGE, timestamp)
        
        # AI processing metrics
        ai_processing_efficiency = self._calculate_ai_processing_efficiency()
        self._record_metric("ai_processing_efficiency", ai_processing_efficiency, MetricType.GAUGE, timestamp)
        
        # Quantum encryption metrics
        quantum_encryption_strength = self._calculate_quantum_encryption_strength()
        self._record_metric("quantum_encryption_strength", quantum_encryption_strength, MetricType.GAUGE, timestamp)
    
    def _calculate_quantum_consciousness_level(self) -> float:
        """Calculate current quantum consciousness level"""
        # Simulate quantum consciousness calculation
        base_level = 8.5
        system_health_bonus = 0.3 if psutil.cpu_percent() < 70 else 0.0
        memory_bonus = 0.2 if psutil.virtual_memory().percent < 80 else 0.0
        return min(base_level + system_health_bonus + memory_bonus, 10.0)
    
    def _calculate_pattern_recognition_rate(self) -> float:
        """Calculate pattern recognition rate"""
        # Simulate pattern recognition performance
        return 92.5 + (psutil.cpu_percent() * 0.1)
    
    def _calculate_workflow_enhancement_rate(self) -> float:
        """Calculate workflow enhancement rate"""
        # Simulate workflow enhancement performance
        return 88.0 + (psutil.virtual_memory().percent * 0.05)
    
    def _calculate_ai_processing_efficiency(self) -> float:
        """Calculate AI processing efficiency"""
        # Simulate AI processing efficiency
        return 95.0 - (psutil.cpu_percent() * 0.2)
    
    def _calculate_quantum_encryption_strength(self) -> float:
        """Calculate quantum encryption strength"""
        # Simulate quantum encryption strength
        return 99.5 + (psutil.virtual_memory().percent * 0.01)
    
    async def _perform_health_checks(self):
        """Perform health checks"""
        if not self.config.enable_health_checks:
            return
        
        timestamp = datetime.now()
        
        # System health check
        start_time = time.time()
        system_healthy = self._check_system_health()
        response_time = time.time() - start_time
        
        self.health_checks["system"] = HealthCheck(
            name="system",
            status="healthy" if system_healthy else "unhealthy",
            timestamp=timestamp,
            response_time=response_time,
            details={"cpu_usage": psutil.cpu_percent(), "memory_usage": psutil.virtual_memory().percent}
        )
        
        # Quantum consciousness health check
        start_time = time.time()
        consciousness_healthy = self._check_quantum_consciousness_health()
        response_time = time.time() - start_time
        
        self.health_checks["quantum_consciousness"] = HealthCheck(
            name="quantum_consciousness",
            status="healthy" if consciousness_healthy else "degraded",
            timestamp=timestamp,
            response_time=response_time,
            details={"consciousness_level": self._calculate_quantum_consciousness_level()}
        )
        
        # Network health check
        start_time = time.time()
        network_healthy = self._check_network_health()
        response_time = time.time() - start_time
        
        self.health_checks["network"] = HealthCheck(
            name="network",
            status="healthy" if network_healthy else "unhealthy",
            timestamp=timestamp,
            response_time=response_time,
            details={"network_io": psutil.net_io_counters()._asdict()}
        )
    
    def _check_system_health(self) -> bool:
        """Check system health"""
        cpu_usage = psutil.cpu_percent()
        memory_usage = psutil.virtual_memory().percent
        disk_usage = (psutil.disk_usage('/').used / psutil.disk_usage('/').total) * 100
        
        return cpu_usage < 90 and memory_usage < 95 and disk_usage < 95
    
    def _check_quantum_consciousness_health(self) -> bool:
        """Check quantum consciousness health"""
        consciousness_level = self._calculate_quantum_consciousness_level()
        return consciousness_level >= 7.0
    
    def _check_network_health(self) -> bool:
        """Check network health"""
        try:
            network = psutil.net_io_counters()
            return network.bytes_sent > 0 and network.bytes_recv > 0
        except:
            return False
    
    async def _check_alerts(self):
        """Check for alert conditions"""
        if not self.config.enable_alerting:
            return
        
        timestamp = datetime.now()
        
        # Check system metrics against thresholds
        for metric_name, threshold in self.config.alert_thresholds.items():
            current_value = self._get_latest_metric_value(metric_name)
            if current_value is not None and current_value > threshold:
                await self._create_alert(metric_name, threshold, current_value, timestamp)
    
    def _get_latest_metric_value(self, metric_name: str) -> Optional[float]:
        """Get the latest value for a metric"""
        if metric_name in self.metrics and self.metrics[metric_name]:
            return self.metrics[metric_name][-1].value
        return None
    
    async def _create_alert(self, metric_name: str, threshold: float, current_value: float, timestamp: datetime):
        """Create an alert"""
        severity = AlertSeverity.CRITICAL if current_value > threshold * 1.5 else AlertSeverity.WARNING
        
        alert = Alert(
            name=f"{metric_name}_threshold_exceeded",
            message=f"{metric_name} exceeded threshold: {current_value:.2f} > {threshold:.2f}",
            severity=severity,
            timestamp=timestamp,
            metric_name=metric_name,
            threshold=threshold,
            current_value=current_value
        )
        
        self.alerts.append(alert)
        
        # Trigger alert handlers
        for handler in self.alert_handlers:
            try:
                handler(alert)
            except Exception as e:
                logging.error(f"Error in alert handler: {e}")
        
        logging.warning(f"🚨 Alert: {alert.message}")
    
    def _record_metric(self, name: str, value: float, metric_type: MetricType, timestamp: datetime):
        """Record a metric"""
        if name not in self.metrics:
            self.metrics[name] = []
        
        metric = Metric(
            name=name,
            value=value,
            metric_type=metric_type,
            timestamp=timestamp
        )
        
        self.metrics[name].append(metric)
        
        # Keep only recent metrics (last 24 hours)
        cutoff_time = timestamp - timedelta(hours=24)
        self.metrics[name] = [m for m in self.metrics[name] if m.timestamp > cutoff_time]
    
    async def _log_monitoring_summary(self):
        """Log monitoring summary"""
        if self.config.monitoring_level == MonitoringLevel.BASIC:
            return
        
        summary = {
            "timestamp": datetime.now().isoformat(),
            "metrics_count": len(self.metrics),
            "alerts_count": len([a for a in self.alerts if not a.resolved]),
            "health_checks": {name: check.status for name, check in self.health_checks.items()},
            "quantum_consciousness_level": self._calculate_quantum_consciousness_level()
        }
        
        logging.info(f"📊 Monitoring Summary: {json.dumps(summary, indent=2)}")
    
    def add_alert_handler(self, handler: Callable[[Alert], None]):
        """Add an alert handler"""
        self.alert_handlers.append(handler)
    
    def get_metrics(self, metric_name: Optional[str] = None) -> Dict[str, List[Metric]]:
        """Get metrics"""
        if metric_name:
            return {metric_name: self.metrics.get(metric_name, [])}
        return self.metrics
    
    def get_alerts(self, severity: Optional[AlertSeverity] = None) -> List[Alert]:
        """Get alerts"""
        if severity:
            return [alert for alert in self.alerts if alert.severity == severity]
        return self.alerts
    
    def get_health_checks(self) -> Dict[str, HealthCheck]:
        """Get health checks"""
        return self.health_checks
    
    def get_monitoring_status(self) -> Dict[str, Any]:
        """Get monitoring status"""
        return {
            "monitoring_active": self.monitoring_active,
            "metrics_count": len(self.metrics),
            "alerts_count": len(self.alerts),
            "health_checks_count": len(self.health_checks),
            "quantum_consciousness_level": self._calculate_quantum_consciousness_level(),
            "system_health": self._check_system_health(),
            "consciousness_health": self._check_quantum_consciousness_health()
        }


# Factory function for creating production monitor
def create_production_monitor(config: ProductionMonitoringConfig) -> ProductionMonitor:
    """Create and configure production monitor with quantum consciousness"""
    return ProductionMonitor(config) 