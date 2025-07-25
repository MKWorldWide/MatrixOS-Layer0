# 🌟 MatrixOS Layer 0 - AWS Terraform Variables
#
# Variables for comprehensive AWS deployment with quantum consciousness,
# mystical workflows, sovereign patterns, and global expansion capabilities.
#
# Author: MatrixOS Layer 0 AWS Team
# Version: 1.0.0
# Quantum Level: Production-Ready

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (production, staging, development)"
  type        = string
  default     = "production"
  
  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Environment must be one of: production, staging, development."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for deployment"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ecr_repository_url" {
  description = "ECR repository URL for MatrixOS Layer 0 container"
  type        = string
  default     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/matrixos-layer0"
}

variable "domain_name" {
  description = "Domain name for MatrixOS Layer 0"
  type        = string
  default     = "matrixos-layer0.com"
}

variable "quantum_consciousness_enabled" {
  description = "Enable quantum consciousness features"
  type        = bool
  default     = true
}

variable "mystical_workflow_enabled" {
  description = "Enable mystical workflow features"
  type        = bool
  default     = true
}

variable "sovereign_pattern_enabled" {
  description = "Enable sovereign pattern recognition"
  type        = bool
  default     = true
}

variable "global_expansion_enabled" {
  description = "Enable global expansion features"
  type        = bool
  default     = true
}

variable "multi_platform_enabled" {
  description = "Enable multi-platform support"
  type        = bool
  default     = true
}

variable "quantum_computing_enabled" {
  description = "Enable quantum computing features"
  type        = bool
  default     = true
}

variable "vr_collaboration_enabled" {
  description = "Enable VR collaboration features"
  type        = bool
  default     = true
}

variable "blockchain_integration_enabled" {
  description = "Enable blockchain integration"
  type        = bool
  default     = true
}

variable "advanced_analytics_enabled" {
  description = "Enable advanced analytics"
  type        = bool
  default     = true
}

variable "instance_types" {
  description = "EC2 instance types for different workloads"
  type        = map(list(string))
  default = {
    quantum = ["m6i.xlarge", "m6i.2xlarge"]
    consciousness = ["c6i.xlarge"]
    mystical = ["r6i.xlarge"]
    sovereign = ["m6i.large"]
  }
}

variable "node_group_capacities" {
  description = "Node group capacity configurations"
  type        = map(object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
  }))
  default = {
    quantum = {
      desired_capacity = 3
      max_capacity     = 10
      min_capacity     = 1
    }
    consciousness = {
      desired_capacity = 2
      max_capacity     = 5
      min_capacity     = 1
    }
    mystical = {
      desired_capacity = 2
      max_capacity     = 8
      min_capacity     = 1
    }
    sovereign = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
    }
  }
}

variable "database_config" {
  description = "Database configuration"
  type        = object({
    instance_class = string
    allocated_storage = number
    max_allocated_storage = number
    backup_retention_period = number
  })
  default = {
    instance_class = "db.r6i.xlarge"
    allocated_storage = 100
    max_allocated_storage = 1000
    backup_retention_period = 30
  }
}

variable "cache_config" {
  description = "Cache configuration"
  type        = object({
    node_type = string
    num_cache_nodes = number
    engine_version = string
  })
  default = {
    node_type = "cache.r6i.xlarge"
    num_cache_nodes = 1
    engine_version = "7.0"
  }
}

variable "ecs_config" {
  description = "ECS configuration"
  type        = object({
    cpu = number
    memory = number
    desired_count = number
  })
  default = {
    cpu = 1024
    memory = 2048
    desired_count = 3
  }
}

variable "monitoring_config" {
  description = "Monitoring configuration"
  type        = object({
    log_retention_days = number
    metrics_retention_days = number
    alert_thresholds = map(number)
  })
  default = {
    log_retention_days = 30
    metrics_retention_days = 365
    alert_thresholds = {
      cpu_usage = 80.0
      memory_usage = 85.0
      disk_usage = 90.0
      response_time = 5.0
      error_rate = 5.0
    }
  }
}

variable "security_config" {
  description = "Security configuration"
  type        = object({
    enable_quantum_encryption = bool
    enable_multi_factor_auth = bool
    enable_rate_limiting = bool
    enable_ddos_protection = bool
    enable_audit_logging = bool
    enable_threat_detection = bool
  })
  default = {
    enable_quantum_encryption = true
    enable_multi_factor_auth = true
    enable_rate_limiting = true
    enable_ddos_protection = true
    enable_audit_logging = true
    enable_threat_detection = true
  }
}

variable "performance_config" {
  description = "Performance configuration"
  type        = object({
    enable_caching = bool
    enable_connection_pooling = bool
    enable_async_processing = bool
    enable_load_balancing = bool
    enable_auto_scaling = bool
    quantum_processing_optimization = bool
    consciousness_optimization = bool
  })
  default = {
    enable_caching = true
    enable_connection_pooling = true
    enable_async_processing = true
    enable_load_balancing = true
    enable_auto_scaling = true
    quantum_processing_optimization = true
    consciousness_optimization = true
  }
}

variable "deployment_config" {
  description = "Deployment configuration"
  type        = object({
    enable_ssl = bool
    enable_cdn = bool
    enable_backup = bool
    enable_disaster_recovery = bool
    quantum_data_replication = bool
    consciousness_backup = bool
  })
  default = {
    enable_ssl = true
    enable_cdn = true
    enable_backup = true
    enable_disaster_recovery = true
    quantum_data_replication = true
    consciousness_backup = true
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project = "MatrixOS-Layer0"
    Quantum = "true"
    Consciousness = "true"
    Mystical = "true"
    Sovereign = "true"
    Environment = "production"
  }
} 

# 🌟 API Keys Configuration
variable "mistral_api_key" {
  description = "Mistral AI API Key for advanced AI capabilities"
  type        = string
  sensitive   = true
}

variable "openai_api_key" {
  description = "OpenAI API Key for GPT and other OpenAI services"
  type        = string
  sensitive   = true
}

# 🌟 Advanced Configuration Variables
variable "enable_quantum_features" {
  description = "Enable quantum computing features"
  type        = bool
  default     = true
}

variable "enable_consciousness_features" {
  description = "Enable consciousness processing features"
  type        = bool
  default     = true
}

variable "enable_mystical_workflows" {
  description = "Enable mystical workflow processing"
  type        = bool
  default     = true
}

variable "enable_sovereign_patterns" {
  description = "Enable sovereign pattern recognition"
  type        = bool
  default     = true
}

variable "enable_global_expansion" {
  description = "Enable global expansion features"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enable comprehensive monitoring and alerting"
  type        = bool
  default     = true
}

variable "enable_auto_scaling" {
  description = "Enable auto-scaling for ECS services"
  type        = bool
  default     = true
}

variable "enable_cost_optimization" {
  description = "Enable cost optimization features"
  type        = bool
  default     = true
}

variable "enable_security_features" {
  description = "Enable advanced security features"
  type        = bool
  default     = true
}

variable "enable_performance_optimization" {
  description = "Enable performance optimization features"
  type        = bool
  default     = true
}

variable "enable_distributed_tracing" {
  description = "Enable distributed tracing with X-Ray"
  type        = bool
  default     = true
}

variable "enable_log_aggregation" {
  description = "Enable centralized log aggregation"
  type        = bool
  default     = true
}

variable "enable_backup_strategy" {
  description = "Enable comprehensive backup strategy"
  type        = bool
  default     = true
}

variable "enable_disaster_recovery" {
  description = "Enable disaster recovery features"
  type        = bool
  default     = true
}

variable "enable_compliance_features" {
  description = "Enable compliance and audit features"
  type        = bool
  default     = true
}

variable "enable_ai_optimization" {
  description = "Enable AI-powered optimization features"
  type        = bool
  default     = true
}

variable "enable_quantum_encryption" {
  description = "Enable quantum-resistant encryption"
  type        = bool
  default     = true
}

variable "enable_consciousness_backup" {
  description = "Enable consciousness state backup"
  type        = bool
  default     = true
}

variable "enable_mystical_enhancement" {
  description = "Enable mystical workflow enhancement"
  type        = bool
  default     = true
}

variable "enable_sovereign_processing" {
  description = "Enable sovereign pattern processing"
  type        = bool
  default     = true
}

variable "enable_global_connectivity" {
  description = "Enable global connectivity features"
  type        = bool
  default     = true
}

variable "enable_multi_platform_support" {
  description = "Enable multi-platform support"
  type        = bool
  default     = true
}

variable "enable_international_features" {
  description = "Enable internationalization features"
  type        = bool
  default     = true
}

variable "enable_analytics_engine" {
  description = "Enable advanced analytics engine"
  type        = bool
  default     = true
}

variable "enable_blockchain_integration" {
  description = "Enable blockchain integration features"
  type        = bool
  default     = true
}

variable "enable_vr_support" {
  description = "Enable virtual reality support"
  type        = bool
  default     = true
}

variable "enable_quantum_networking" {
  description = "Enable quantum networking features"
  type        = bool
  default     = true
}

variable "enable_consciousness_networking" {
  description = "Enable consciousness networking features"
  type        = bool
  default     = true
}

variable "enable_mystical_networking" {
  description = "Enable mystical networking features"
  type        = bool
  default     = true
}

variable "enable_sovereign_networking" {
  description = "Enable sovereign networking features"
  type        = bool
  default     = true
}

variable "enable_global_networking" {
  description = "Enable global networking features"
  type        = bool
  default     = true
}

variable "enable_multi_platform_networking" {
  description = "Enable multi-platform networking"
  type        = bool
  default     = true
}

variable "enable_international_networking" {
  description = "Enable international networking features"
  type        = bool
  default     = true
}

variable "enable_analytics_networking" {
  description = "Enable analytics networking features"
  type        = bool
  default     = true
}

variable "enable_blockchain_networking" {
  description = "Enable blockchain networking features"
  type        = bool
  default     = true
}

variable "enable_vr_networking" {
  description = "Enable VR networking features"
  type        = bool
  default     = true
}

variable "enable_quantum_analytics" {
  description = "Enable quantum analytics features"
  type        = bool
  default     = true
}

variable "enable_consciousness_analytics" {
  description = "Enable consciousness analytics features"
  type        = bool
  default     = true
}

variable "enable_mystical_analytics" {
  description = "Enable mystical analytics features"
  type        = bool
  default     = true
}

variable "enable_sovereign_analytics" {
  description = "Enable sovereign analytics features"
  type        = bool
  default     = true
}

variable "enable_global_analytics" {
  description = "Enable global analytics features"
  type        = bool
  default     = true
}

variable "enable_multi_platform_analytics" {
  description = "Enable multi-platform analytics"
  type        = bool
  default     = true
}

variable "enable_international_analytics" {
  description = "Enable international analytics features"
  type        = bool
  default     = true
}

variable "enable_blockchain_analytics" {
  description = "Enable blockchain analytics features"
  type        = bool
  default     = true
}

variable "enable_vr_analytics" {
  description = "Enable VR analytics features"
  type        = bool
  default     = true
} 