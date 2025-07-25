# 🌟 MatrixOS Layer 0 - AWS Terraform Variables Example
#
# Example configuration file for AWS deployment with quantum consciousness,
# mystical workflows, sovereign patterns, and global expansion capabilities.
#
# Copy this file to terraform.tfvars and update with your actual values.
#
# Author: MatrixOS Layer 0 AWS Team
# Version: 1.0.0
# Quantum Level: Production-Ready

# 🌟 Basic Configuration
aws_region = "us-east-1"
environment = "production"

# 🌟 Network Configuration
vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# 🌟 Database Configuration (REQUIRED - Update with secure values)
db_username = "matrixos_admin"
db_password = "MatrixOS_Layer0_Quantum_2024!"

# 🌟 ECR Repository (Update with your actual ECR repository URL)
ecr_repository_url = "869935067006.dkr.ecr.us-east-1.amazonaws.com/matrixos-layer0"

# 🌟 API Keys Configuration
# 🌟 IMPORTANT: Set these via environment variables or AWS Secrets Manager
# 🌟 DO NOT hardcode API keys in this file
mistral_api_key = ""  # Set via MISTRAL_API_KEY environment variable
openai_api_key = ""   # Set via OPENAI_API_KEY environment variable

# 🌟 Domain Configuration (Update with your actual domain)
domain_name = "matrixos-layer0.com"

# 🌟 Feature Flags - Quantum Consciousness
quantum_consciousness_enabled = true
mystical_workflow_enabled = true
sovereign_pattern_enabled = true
global_expansion_enabled = true
multi_platform_enabled = true
quantum_computing_enabled = true
vr_collaboration_enabled = true
blockchain_integration_enabled = true
advanced_analytics_enabled = true

# 🌟 Instance Types for Different Workloads
instance_types = {
  quantum = ["t3.medium", "t3.small"]
  consciousness = ["t3.small"]
  mystical = ["t3.small"]
  sovereign = ["t3.small"]
}

# 🌟 Node Group Capacities
node_group_capacities = {
  quantum = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
  }
  consciousness = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
  }
  mystical = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
  }
  sovereign = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
  }
}

# 🌟 Database Configuration
database_config = {
  instance_class = "db.t3.micro"
  allocated_storage = 20
  max_allocated_storage = 100
  backup_retention_period = 7
}

# 🌟 Cache Configuration
cache_config = {
  node_type = "cache.t3.micro"
  num_cache_nodes = 1
  engine_version = "7.0"
}

# 🌟 ECS Configuration
ecs_config = {
  cpu = 256
  memory = 512
  desired_count = 1
}

# 🌟 Monitoring Configuration
monitoring_config = {
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

# 🌟 Security Configuration
security_config = {
  enable_quantum_encryption = true
  enable_multi_factor_auth = true
  enable_rate_limiting = true
  enable_ddos_protection = true
  enable_audit_logging = true
  enable_threat_detection = true
}

# 🌟 Performance Configuration
performance_config = {
  enable_caching = true
  enable_connection_pooling = true
  enable_async_processing = true
  enable_load_balancing = true
  enable_auto_scaling = true
  quantum_processing_optimization = true
  consciousness_optimization = true
}

# 🌟 Deployment Configuration
deployment_config = {
  enable_ssl = true
  enable_cdn = true
  enable_backup = true
  enable_disaster_recovery = true
  quantum_data_replication = true
  consciousness_backup = true
}

# 🌟 Common Tags
tags = {
  Project = "MatrixOS-Layer0"
  Quantum = "true"
  Consciousness = "true"
  Mystical = "true"
  Sovereign = "true"
  Environment = "production"
  Team = "MatrixOS"
  CostCenter = "R&D"
  DataClassification = "Confidential"
} 