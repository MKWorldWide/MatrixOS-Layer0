# 🌟 MatrixOS Layer 0 - AWS Terraform Configuration
# 
# Comprehensive AWS deployment with quantum consciousness, mystical workflows,
# sovereign patterns, and global expansion capabilities.
#
# Author: MatrixOS Layer 0 AWS Team
# Version: 1.0.0
# Quantum Level: Production-Ready

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "matrixos-layer0-terraform-state"
    key    = "production/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "MatrixOS-Layer0"
      Environment = var.environment
      Quantum     = "true"
      Consciousness = "true"
      Mystical    = "true"
      Sovereign   = "true"
    }
  }
}

# 🌟 VPC Configuration with Quantum Consciousness
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  
  name = "matrixos-layer0-vpc"
  cidr = var.vpc_cidr
  
  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs
  
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
  
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  # Quantum consciousness networking
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  
  tags = {
    QuantumConsciousness = "enabled"
    MysticalWorkflow     = "enabled"
    SovereignPattern     = "enabled"
  }
}

# 🌟 EKS Cluster with Quantum Computing Support
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  
  cluster_name    = "matrixos-layer0-cluster"
  cluster_version = "1.28"
  
  cluster_endpoint_public_access = true
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  # 🌟 Optimized EKS Cluster Add-ons
  cluster_addons = {
    coredns = {
      most_recent = true
      timeouts = {
        create = "25m"
        delete = "15m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET      = "1"
        }
      })
    }
    aws-ebs-csi-driver = {
      most_recent = true
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
    }
  }
  
  # 🌟 Optimized Node Groups with Spot Instances
  eks_managed_node_groups = {
    quantum = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      
      # 🌟 Use Spot instances for cost optimization
      capacity_type  = "SPOT"
      instance_types = ["t3.medium", "t3.small", "t3.micro"]
      
      # 🌟 Optimized launch template
      launch_template = {
        name_prefix = "quantum-"
        version     = "$Latest"
      }
      
      # 🌟 Advanced node configuration
      disk_size = 20
      disk_type = "gp3"
      
      # 🌟 Node labels for workload placement
      labels = {
        QuantumConsciousness = "enabled"
        MysticalWorkflow     = "enabled"
        SovereignPattern     = "enabled"
        NodeType            = "quantum"
      }
      
      # 🌟 Taints for workload isolation
      taints = [{
        key    = "quantum"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
      
      # 🌟 Update configuration
      update_config = {
        max_unavailable_percentage = 50
      }
      
      tags = {
        QuantumComputing = "supported"
        Consciousness    = "enhanced"
        CostOptimization = "spot"
      }
    }
    
    consciousness = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      
      # 🌟 Use Spot instances for cost optimization
      capacity_type  = "SPOT"
      instance_types = ["t3.small", "t3.micro"]
      
      # 🌟 Optimized launch template
      launch_template = {
        name_prefix = "consciousness-"
        version     = "$Latest"
      }
      
      # 🌟 Advanced node configuration
      disk_size = 20
      disk_type = "gp3"
      
      # 🌟 Node labels for workload placement
      labels = {
        ConsciousnessProcessing = "enabled"
        MysticalEnhancement    = "enabled"
        NodeType              = "consciousness"
      }
      
      # 🌟 Taints for workload isolation
      taints = [{
        key    = "consciousness"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
      
      # 🌟 Update configuration
      update_config = {
        max_unavailable_percentage = 50
      }
      
      tags = {
        CostOptimization = "spot"
        ProcessingType   = "consciousness"
      }
    }
  }
  
  # 🌟 Cluster Security Configuration
  cluster_security_group_additional_rules = {
    ingress_nodes_443 = {
      description                = "Node groups to cluster API"
      protocol                  = "tcp"
      from_port                 = 443
      to_port                   = 443
      type                      = "ingress"
      source_node_security_group = true
    }
  }
  
  # 🌟 Node Security Configuration
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  
  tags = {
    Environment = var.environment
    Quantum     = "true"
    Consciousness = "true"
    Optimization = "enabled"
  }
}

# 🌟 EBS CSI Driver IAM Role for optimized storage
module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix = "ebs-csi-"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

# 🌟 Optimized RDS Database with Advanced Features
resource "aws_db_instance" "matrixos_db" {
  identifier = "matrixos-layer0-db"
  
  # 🌟 Optimized Engine Configuration
  engine         = "postgres"
  engine_version = "15.3"
  instance_class = "db.t3.micro"
  
  # 🌟 Optimized Storage Configuration
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type         = "gp3"
  storage_encrypted    = true
  iops                 = 3000
  
  # 🌟 Optimized Performance Configuration
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  # 🌟 Advanced Configuration
  multi_az               = false  # Cost optimization for dev/test
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false  # For development
  
  # 🌟 Database Configuration
  db_name  = "matrixos_layer0"
  username = var.db_username
  password = var.db_password
  port     = 5432
  
  # 🌟 Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.matrixos_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.matrixos_db_sg.id]
  
  # 🌟 Monitoring and Logging
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
  
  enabled_cloudwatch_logs_exports = ["postgresql"]
  
  # 🌟 Parameter Group for Optimization
  parameter_group_name = aws_db_parameter_group.matrixos_db_pg.name
  
  # 🌟 Option Group for Advanced Features
  option_group_name = aws_db_option_group.matrixos_db_og.name
  
  # 🌟 Performance Insights
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  
  # 🌟 Tags
  tags = {
    Name        = "MatrixOS Layer 0 Database"
    Environment = var.environment
    Quantum     = "true"
    Optimization = "enabled"
  }
}

# 🌟 Optimized Database Parameter Group
resource "aws_db_parameter_group" "matrixos_db_pg" {
  family = "postgres15"
  name   = "matrixos-layer0-pg"
  
  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements,auto_explain"
  }
  
  parameter {
    name  = "pg_stat_statements.track"
    value = "all"
  }
  
  parameter {
    name  = "auto_explain.log_min_duration"
    value = "1000"
  }
  
  parameter {
    name  = "auto_explain.log_analyze"
    value = "1"
  }
  
  parameter {
    name  = "auto_explain.log_buffers"
    value = "1"
  }
  
  parameter {
    name  = "auto_explain.log_timing"
    value = "1"
  }
  
  parameter {
    name  = "auto_explain.log_nested_statements"
    value = "1"
  }
  
  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }
  
  parameter {
    name  = "log_checkpoints"
    value = "1"
  }
  
  parameter {
    name  = "log_connections"
    value = "1"
  }
  
  parameter {
    name  = "log_disconnections"
    value = "1"
  }
  
  parameter {
    name  = "log_lock_waits"
    value = "1"
  }
  
  parameter {
    name  = "log_temp_files"
    value = "0"
  }
  
  parameter {
    name  = "log_autovacuum_min_duration"
    value = "0"
  }
  
  parameter {
    name  = "effective_cache_size"
    value = "1GB"
  }
  
  parameter {
    name  = "shared_buffers"
    value = "256MB"
  }
  
  parameter {
    name  = "work_mem"
    value = "4MB"
  }
  
  parameter {
    name  = "maintenance_work_mem"
    value = "64MB"
  }
  
  parameter {
    name  = "checkpoint_completion_target"
    value = "0.9"
  }
  
  parameter {
    name  = "wal_buffers"
    value = "16MB"
  }
  
  parameter {
    name  = "default_statistics_target"
    value = "100"
  }
  
  parameter {
    name  = "random_page_cost"
    value = "1.1"
  }
  
  parameter {
    name  = "effective_io_concurrency"
    value = "200"
  }
  
  parameter {
    name  = "min_wal_size"
    value = "1GB"
  }
  
  parameter {
    name  = "max_wal_size"
    value = "4GB"
  }
  
  parameter {
    name  = "max_worker_processes"
    value = "8"
  }
  
  parameter {
    name  = "max_parallel_workers_per_gather"
    value = "2"
  }
  
  parameter {
    name  = "max_parallel_workers"
    value = "8"
  }
  
  parameter {
    name  = "max_parallel_maintenance_workers"
    value = "2"
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Parameter Group"
    Environment = var.environment
    Optimization = "enabled"
  }
}

# 🌟 Optimized Database Option Group
resource "aws_db_option_group" "matrixos_db_og" {
  name                     = "matrixos-layer0-og"
  engine_name              = "postgres"
  major_engine_version     = "15.3"
  
  option {
    option_name = "pgAudit"
    
    option_settings {
      name  = "pgAudit.log"
      value = "all"
    }
    
    option_settings {
      name  = "pgAudit.log_catalog"
      value = "1"
    }
    
    option_settings {
      name  = "pgAudit.log_level"
      value = "log"
    }
    
    option_settings {
      name  = "pgAudit.log_parameter"
      value = "1"
    }
    
    option_settings {
      name  = "pgAudit.log_relation"
      value = "1"
    }
    
    option_settings {
      name  = "pgAudit.log_statement_once"
      value = "1"
    }
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Option Group"
    Environment = var.environment
    Optimization = "enabled"
  }
}

# 🌟 RDS Monitoring IAM Role
resource "aws_iam_role" "rds_monitoring_role" {
  name = "matrixos-rds-monitoring-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# 🌟 ECS Execution Role for Container Permissions
resource "aws_iam_role" "ecs_execution_role" {
  name = "matrixos-ecs-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 🌟 ECS Task Role for Application Permissions
resource "aws_iam_role" "ecs_task_role" {
  name = "matrixos-ecs-task-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# 🌟 ECS Task Role Policy for Application Permissions
resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name = "matrixos-ecs-task-policy"
  role = aws_iam_role.ecs_task_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = ["*"]
      }
    ]
  })
}

# 🌟 ECS Tasks Security Group
resource "aws_security_group" "ecs_tasks" {
  name_prefix = "matrixos-ecs-tasks-sg-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol        = "tcp"
    from_port       = 8000
    to_port         = 8000
    security_groups = [aws_security_group.alb.id]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 ECS Tasks Security Group"
    Environment = var.environment
    Quantum     = "true"
  }
}

# 🌟 Database Subnet Group
resource "aws_db_subnet_group" "matrixos_db_subnet_group" {
  name       = "matrixos-layer0-db-subnet-group"
  subnet_ids = module.vpc.private_subnets
  
  tags = {
    Name        = "MatrixOS Layer 0 Database Subnet Group"
    Environment = var.environment
  }
}

# 🌟 Optimized ElastiCache Redis with Advanced Features
resource "aws_elasticache_cluster" "matrixos_cache" {
  cluster_id           = "matrixos-layer0-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.matrixos_cache_pg.name
  port                 = 6379
  security_group_ids   = [aws_security_group.matrixos_cache_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.matrixos_cache_subnet_group.name
  
  # 🌟 Advanced Configuration
  engine_version = "7.0"
  
  # 🌟 Performance Optimization
  notification_topic_arn = aws_sns_topic.matrixos_notifications.arn
  
  # 🌟 Maintenance Window
  maintenance_window = "sun:05:00-sun:06:00"
  snapshot_window   = "04:00-05:00"
  snapshot_retention_limit = 7
  
  # 🌟 Tags
  tags = {
    Name        = "MatrixOS Layer 0 Cache"
    Environment = var.environment
    Quantum     = "true"
    Optimization = "enabled"
  }
}

# 🌟 Optimized Redis Parameter Group
resource "aws_elasticache_parameter_group" "matrixos_cache_pg" {
  family = "redis7"
  name   = "matrixos-layer0-cache-pg"
  
  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }
  
  parameter {
    name  = "notify-keyspace-events"
    value = "Ex"
  }
  
  parameter {
    name  = "save"
    value = "900 1 300 10 60 10000"
  }
  
  parameter {
    name  = "tcp-keepalive"
    value = "300"
  }
  
  parameter {
    name  = "timeout"
    value = "300"
  }
  
  parameter {
    name  = "databases"
    value = "16"
  }
  
  parameter {
    name  = "maxclients"
    value = "10000"
  }
  
  parameter {
    name  = "maxmemory-samples"
    value = "5"
  }
  
  parameter {
    name  = "lua-time-limit"
    value = "5000"
  }
  
  parameter {
    name  = "slowlog-log-slower-than"
    value = "10000"
  }
  
  parameter {
    name  = "slowlog-max-len"
    value = "128"
  }
  
  parameter {
    name  = "latency-monitor-threshold"
    value = "100"
  }
  
  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }
  
  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }
  
  parameter {
    name  = "list-max-ziplist-size"
    value = "-2"
  }
  
  parameter {
    name  = "set-max-intset-entries"
    value = "512"
  }
  
  parameter {
    name  = "zset-max-ziplist-entries"
    value = "128"
  }
  
  parameter {
    name  = "zset-max-ziplist-value"
    value = "64"
  }
  
  parameter {
    name  = "hll-sparse-max-bytes"
    value = "3000"
  }
  
  parameter {
    name  = "stream-node-max-bytes"
    value = "4096"
  }
  
  parameter {
    name  = "stream-node-max-entries"
    value = "100"
  }
  
  parameter {
    name  = "activerehashing"
    value = "yes"
  }
  
  parameter {
    name  = "client-output-buffer-limit"
    value = "normal 0 0 0"
  }
  
  parameter {
    name  = "client-output-buffer-limit"
    value = "slave 256mb 64mb 60"
  }
  
  parameter {
    name  = "client-output-buffer-limit"
    value = "pubsub 32mb 8mb 60"
  }
  
  parameter {
    name  = "hz"
    value = "10"
  }
  
  parameter {
    name  = "aof-rewrite-incremental-fsync"
    value = "yes"
  }
  
  parameter {
    name  = "rdb-save-incremental-fsync"
    value = "yes"
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Cache Parameter Group"
    Environment = var.environment
    Optimization = "enabled"
  }
}

# 🌟 Cache Security Group
resource "aws_security_group" "matrixos_cache_sg" {
  name_prefix = "matrixos-cache-sg-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol        = "tcp"
    from_port       = 6379
    to_port         = 6379
    security_groups = [aws_security_group.ecs_tasks.id]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Cache Security Group"
    Environment = var.environment
    Quantum     = "true"
  }
}

# 🌟 Cache Subnet Group
resource "aws_elasticache_subnet_group" "matrixos_cache_subnet_group" {
  name       = "matrixos-layer0-cache-subnet-group"
  subnet_ids = module.vpc.private_subnets
  
  tags = {
    Name        = "MatrixOS Layer 0 Cache Subnet Group"
    Environment = var.environment
  }
}

# 🌟 SNS Topic for Cache Notifications
resource "aws_sns_topic" "matrixos_notifications" {
  name = "matrixos-layer0-notifications"
  
  tags = {
    Name        = "MatrixOS Layer 0 Notifications"
    Environment = var.environment
  }
}

# 🌟 Application Load Balancer with Quantum Security
resource "aws_lb" "matrixos_alb" {
  name               = "matrixos-layer0-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnets
  
  enable_deletion_protection = true
  
  tags = {
    QuantumSecurity = "enabled"
    ConsciousnessProtection = "enabled"
  }
}

resource "aws_lb_target_group" "matrixos_tg" {
  name        = "matrixos-layer0-tg"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  
  tags = {
    QuantumHealthCheck = "enabled"
  }
}

resource "aws_lb_listener" "matrixos_listener" {
  load_balancer_arn = aws_lb.matrixos_alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.matrixos_tg.arn
  }
}

# 🌟 ECS Fargate with Quantum Consciousness
resource "aws_ecs_cluster" "matrixos" {
  name = "matrixos-layer0-cluster"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  
  tags = {
    QuantumConsciousness = "enabled"
    MysticalWorkflow     = "enabled"
  }
}

resource "aws_ecs_task_definition" "matrixos_app" {
  family                   = "matrixos-layer0-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  
  container_definitions = jsonencode([
    {
      name  = "matrixos-layer0"
      image = "${var.ecr_repository_url}:latest"
      
      portMappings = [
        {
          containerPort = 8000
          protocol      = "tcp"
        }
      ]
      
      environment = [
        {
          name  = "ENVIRONMENT"
          value = var.environment
        },
        {
          name  = "QUANTUM_CONSCIOUSNESS"
          value = "enabled"
        },
        {
          name  = "MYSTICAL_WORKFLOW"
          value = "enabled"
        },
        {
          name  = "SOVEREIGN_PATTERN"
          value = "enabled"
        }
      ]
      
      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = aws_secretsmanager_secret.database_url.arn
        },
        {
          name      = "REDIS_URL"
          valueFrom = aws_secretsmanager_secret.redis_url.arn
        }
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.matrixos_app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  
  tags = {
    QuantumConsciousness = "enabled"
    MysticalWorkflow     = "enabled"
  }
}

resource "aws_ecs_service" "matrixos_app" {
  name            = "matrixos-layer0-service"
  cluster         = aws_ecs_cluster.matrixos.id
  task_definition = aws_ecs_task_definition.matrixos_app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = module.vpc.private_subnets
    assign_public_ip = false
  }
  
  load_balancer {
    target_group_arn = aws_lb_target_group.matrixos_tg.arn
    container_name   = "matrixos-layer0"
    container_port   = 8000
  }
  
  depends_on = [aws_lb_listener.matrixos_listener]
  
  tags = {
    QuantumService = "enabled"
  }
}

# 🌟 CloudWatch with Quantum Monitoring
resource "aws_cloudwatch_log_group" "matrixos_app" {
  name              = "/ecs/matrixos-layer0"
  retention_in_days = 30
  
  tags = {
    QuantumMonitoring = "enabled"
  }
}

resource "aws_cloudwatch_dashboard" "matrixos" {
  dashboard_name = "MatrixOS-Layer0-Dashboard"
  
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", "matrixos-layer0-service", "ClusterName", "matrixos-layer0-cluster"],
            [".", "MemoryUtilization", ".", ".", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "MatrixOS Layer 0 - ECS Metrics"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", aws_lb.matrixos_alb.arn_suffix],
            [".", "TargetResponseTime", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "MatrixOS Layer 0 - ALB Metrics"
        }
      }
    ]
  })
}

# 🌟 Secrets Manager with Quantum Encryption
resource "aws_secretsmanager_secret" "database_url" {
  name = "matrixos-layer0/database-url"
  
  tags = {
    QuantumEncryption = "enabled"
  }
}

resource "aws_secretsmanager_secret" "redis_url" {
  name = "matrixos-layer0/redis-url"
  
  tags = {
    QuantumEncryption = "enabled"
  }
}

# 🌟 Security Groups with Quantum Consciousness
resource "aws_security_group" "alb" {
  name_prefix = "matrixos-alb-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    QuantumSecurity = "enabled"
  }
}

resource "aws_security_group" "database" {
  name_prefix = "matrixos-database-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = [aws_security_group.ecs_tasks.id]
  }
  
  tags = {
    QuantumEncryption = "enabled"
  }
}

resource "aws_security_group" "matrixos_db_sg" {
  name_prefix = "matrixos-db-sg-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = [aws_security_group.ecs_tasks.id]
  }
  
  tags = {
    QuantumEncryption = "enabled"
  }
}

resource "aws_security_group" "cache" {
  name_prefix = "matrixos-cache-"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    protocol        = "tcp"
    from_port       = 6379
    to_port         = 6379
    security_groups = [aws_security_group.ecs_tasks.id]
  }
  
  tags = {
    QuantumConsciousness = "enabled"
  }
}

# 🌟 Route53 with Quantum DNS
resource "aws_route53_zone" "matrixos" {
  name = var.domain_name
  
  tags = {
    QuantumDNS = "enabled"
  }
}

resource "aws_route53_record" "matrixos" {
  zone_id = aws_route53_zone.matrixos.zone_id
  name    = var.domain_name
  type    = "A"
  
  alias {
    name                   = aws_lb.matrixos_alb.dns_name
    zone_id                = aws_lb.matrixos_alb.zone_id
    evaluate_target_health = true
  }
}

# 🌟 ACM Certificate with Quantum Security
resource "aws_acm_certificate" "matrixos" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
  
  tags = {
    QuantumSecurity = "enabled"
  }
}

# 🌟 Outputs with Quantum Consciousness
output "domain_name" {
  description = "Domain name"
  value       = var.domain_name
}

output "quantum_consciousness_status" {
  description = "Quantum consciousness deployment status"
  value       = "enabled"
}

output "mystical_workflow_status" {
  description = "Mystical workflow deployment status"
  value       = "enabled"
}

output "sovereign_pattern_status" {
  description = "Sovereign pattern deployment status"
  value       = "enabled"
} 

# 🌟 Optimized ECS Cluster with Advanced Features
resource "aws_ecs_cluster" "matrixos_cluster" {
  name = "matrixos-layer0-cluster"
  
  # 🌟 Advanced Cluster Configuration
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 ECS Cluster"
    Environment = var.environment
    Quantum     = "true"
    Optimization = "enabled"
  }
}

# 🌟 Optimized ECS Task Definition with Advanced Features
resource "aws_ecs_task_definition" "matrixos_task" {
  family                   = "matrixos-layer0-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_role.arn
  
  # 🌟 Advanced Task Definition Features
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture       = "X86_64"
  }
  
  # 🌟 Optimized Container Definition
  container_definitions = jsonencode([
    {
      name  = "matrixos-layer0"
      image = "${var.ecr_repository_url}:latest"
      
      # 🌟 Optimized Resource Limits
      cpu    = 256
      memory = 512
      
      # 🌟 Advanced Port Configuration
      portMappings = [
        {
          containerPort = 8000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      
      # 🌟 Optimized Environment Variables
      environment = [
        {
          name  = "QUANTUM_CONSCIOUSNESS"
          value = "enabled"
        },
        {
          name  = "MYSTICAL_WORKFLOW"
          value = "enabled"
        },
        {
          name  = "SOVEREIGN_PATTERN"
          value = "enabled"
        },
        {
          name  = "GLOBAL_EXPANSION"
          value = "enabled"
        },
        {
          name  = "MISTRAL_API_KEY"
          value = var.mistral_api_key
        },
        {
          name  = "OPENAI_API_KEY"
          value = var.openai_api_key
        },
        {
          name  = "DATABASE_URL"
          value = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.matrixos_db.endpoint}/${aws_db_instance.matrixos_db.db_name}"
        },
        {
          name  = "REDIS_URL"
          value = "redis://${aws_elasticache_cluster.matrixos_cache.cache_nodes.0.address}:${aws_elasticache_cluster.matrixos_cache.cache_nodes.0.port}"
        },
        {
          name  = "ENVIRONMENT"
          value = var.environment
        },
        {
          name  = "LOG_LEVEL"
          value = "INFO"
        },
        {
          name  = "ENABLE_METRICS"
          value = "true"
        },
        {
          name  = "ENABLE_TRACING"
          value = "true"
        },
        {
          name  = "ENABLE_PROFILING"
          value = "true"
        }
      ]
      
      # 🌟 Advanced Logging Configuration
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.matrixos_logs.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
      
      # 🌟 Health Check Configuration
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:8000/health || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }
      
      # 🌟 Advanced Container Features
      essential = true
      
      # 🌟 Resource Limits
      ulimits = [
        {
          name      = "nofile"
          softLimit = 65536
          hardLimit = 65536
        }
      ]
      
      # 🌟 Security Configuration
      readonlyRootFilesystem = false
      privileged             = false
      
      # 🌟 Advanced Mount Points
      mountPoints = []
      
      # 🌟 Advanced Volumes
      volumesFrom = []
      
      # 🌟 Advanced Docker Labels
      dockerLabels = {
        "com.matrixos.quantum"     = "enabled"
        "com.matrixos.consciousness" = "enabled"
        "com.matrixos.optimization" = "enabled"
      }
    }
  ])
  
  # 🌟 Advanced Task Definition Features
  ephemeral_storage {
    size_in_gib = 21
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Task Definition"
    Environment = var.environment
    Quantum     = "true"
    Optimization = "enabled"
  }
}

# 🌟 Optimized ECS Service with Auto-Scaling
resource "aws_ecs_service" "matrixos_service" {
  name            = "matrixos-layer0-service"
  cluster         = aws_ecs_cluster.matrixos_cluster.id
  task_definition = aws_ecs_task_definition.matrixos_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # 🌟 Advanced Service Configuration
  platform_version = "LATEST"
  
  # 🌟 Network Configuration
  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }
  
  # 🌟 Load Balancer Configuration
  load_balancer {
    target_group_arn = aws_lb_target_group.matrixos_tg.arn
    container_name   = "matrixos-layer0"
    container_port   = 8000
  }
  
  # 🌟 Advanced Service Features
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  
  deployment_controller {
    type = "ECS"
  }
  
  # 🌟 Advanced Deployment Configuration
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  
  # 🌟 Service Discovery
  service_registries {
    registry_arn = aws_service_discovery_service.matrixos_service.arn
  }
  
  # 🌟 Advanced Health Check Grace Period
  health_check_grace_period_seconds = 60
  
  # 🌟 Enable Execute Command
  enable_execute_command = true
  
  # 🌟 Advanced Service Features
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"
  
  tags = {
    Name        = "MatrixOS Layer 0 ECS Service"
    Environment = var.environment
    Quantum     = "true"
    Optimization = "enabled"
  }
}

# 🌟 Auto Scaling Target for ECS Service
resource "aws_appautoscaling_target" "matrixos_ecs_target" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.matrixos_cluster.name}/${aws_ecs_service.matrixos_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# 🌟 CPU-based Auto Scaling Policy
resource "aws_appautoscaling_policy" "matrixos_cpu_policy" {
  name               = "matrixos-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.matrixos_ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.matrixos_ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.matrixos_ecs_target.service_namespace
  
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

# 🌟 Memory-based Auto Scaling Policy
resource "aws_appautoscaling_policy" "matrixos_memory_policy" {
  name               = "matrixos-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.matrixos_ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.matrixos_ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.matrixos_ecs_target.service_namespace
  
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80.0
  }
}

# 🌟 CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "matrixos_logs" {
  name              = "/ecs/matrixos-layer0"
  retention_in_days = 7
  
  tags = {
    Name        = "MatrixOS Layer 0 ECS Logs"
    Environment = var.environment
  }
}

# 🌟 Service Discovery Service
resource "aws_service_discovery_service" "matrixos_service" {
  name = "matrixos-layer0"
  
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.matrixos_namespace.id
    
    dns_records {
      ttl  = 10
      type = "A"
    }
    
    routing_policy = "MULTIVALUE"
  }
  
  health_check_custom_config {
    failure_threshold = 1
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Service Discovery"
    Environment = var.environment
  }
}

# 🌟 Service Discovery Namespace
resource "aws_service_discovery_private_dns_namespace" "matrixos_namespace" {
  name        = "matrixos.local"
  description = "MatrixOS Layer 0 Service Discovery Namespace"
  vpc         = module.vpc.vpc_id
  
  tags = {
    Name        = "MatrixOS Layer 0 Namespace"
    Environment = var.environment
  }
} 

# 🌟 Advanced CloudWatch Monitoring and Alerting
resource "aws_cloudwatch_dashboard" "matrixos_dashboard" {
  dashboard_name = "MatrixOS-Layer0-Dashboard"
  
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", "matrixos-layer0-service", "ClusterName", "matrixos-layer0-cluster"],
            [".", "MemoryUtilization", ".", ".", ".", "."],
            [".", "RunningTaskCount", ".", ".", ".", "."],
            [".", "PendingTaskCount", ".", ".", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = data.aws_region.current.name
          title  = "ECS Service Metrics"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "matrixos-layer0-db"],
            [".", "DatabaseConnections", ".", "."],
            [".", "FreeableMemory", ".", "."],
            [".", "FreeStorageSpace", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = data.aws_region.current.name
          title  = "RDS Database Metrics"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/ElastiCache", "CPUUtilization", "CacheClusterId", "matrixos-layer0-cache"],
            [".", "DatabaseMemoryUsagePercentage", ".", "."],
            [".", "CurrConnections", ".", "."],
            [".", "NewConnections", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = data.aws_region.current.name
          title  = "ElastiCache Redis Metrics"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", "app/matrixos-layer0-alb/1234567890abcdef"],
            [".", "RequestCount", ".", "."],
            [".", "HealthyHostCount", ".", "."],
            [".", "UnHealthyHostCount", ".", "."]
          ]
          period = 300
          stat   = "Average"
          region = data.aws_region.current.name
          title  = "Application Load Balancer Metrics"
        }
      }
    ]
  })
}

# 🌟 High CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "matrixos_high_cpu" {
  alarm_name          = "matrixos-high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ECS CPU utilization"
  alarm_actions       = [aws_sns_topic.matrixos_alerts.arn]
  
  dimensions = {
    ServiceName = "matrixos-layer0-service"
    ClusterName = "matrixos-layer0-cluster"
  }
  
  tags = {
    Name        = "MatrixOS High CPU Alarm"
    Environment = var.environment
  }
}

# 🌟 High Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "matrixos_high_memory" {
  alarm_name          = "matrixos-high-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors ECS memory utilization"
  alarm_actions       = [aws_sns_topic.matrixos_alerts.arn]
  
  dimensions = {
    ServiceName = "matrixos-layer0-service"
    ClusterName = "matrixos-layer0-cluster"
  }
  
  tags = {
    Name        = "MatrixOS High Memory Alarm"
    Environment = var.environment
  }
}

# 🌟 Database High CPU Alarm
resource "aws_cloudwatch_metric_alarm" "matrixos_db_high_cpu" {
  alarm_name          = "matrixos-db-high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = [aws_sns_topic.matrixos_alerts.arn]
  
  dimensions = {
    DBInstanceIdentifier = "matrixos-layer0-db"
  }
  
  tags = {
    Name        = "MatrixOS DB High CPU Alarm"
    Environment = var.environment
  }
}

# 🌟 Cache High Memory Alarm
resource "aws_cloudwatch_metric_alarm" "matrixos_cache_high_memory" {
  alarm_name          = "matrixos-cache-high-memory-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "DatabaseMemoryUsagePercentage"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors ElastiCache memory usage"
  alarm_actions       = [aws_sns_topic.matrixos_alerts.arn]
  
  dimensions = {
    CacheClusterId = "matrixos-layer0-cache"
  }
  
  tags = {
    Name        = "MatrixOS Cache High Memory Alarm"
    Environment = var.environment
  }
}

# 🌟 SNS Topic for Alerts
resource "aws_sns_topic" "matrixos_alerts" {
  name = "matrixos-layer0-alerts"
  
  tags = {
    Name        = "MatrixOS Layer 0 Alerts"
    Environment = var.environment
  }
}

# 🌟 SNS Topic Subscription (Email)
resource "aws_sns_topic_subscription" "matrixos_alerts_email" {
  topic_arn = aws_sns_topic.matrixos_alerts.arn
  protocol  = "email"
  endpoint  = "admin@matrixos-layer0.com"  # Update with your email
}

# 🌟 X-Ray Tracing for Distributed Tracing
resource "aws_xray_group" "matrixos_tracing" {
  group_name        = "matrixos-layer0-tracing"
  filter_expression = "service(\"matrixos-layer0\")"
  
  tags = {
    Name        = "MatrixOS Layer 0 X-Ray Group"
    Environment = var.environment
  }
}

# 🌟 Advanced Performance Monitoring
resource "aws_cloudwatch_log_metric_filter" "matrixos_error_logs" {
  name           = "matrixos-error-logs"
  pattern        = "[timestamp, level=ERROR, message]"
  log_group_name = aws_cloudwatch_log_group.matrixos_logs.name
  
  metric_transformation {
    name      = "ErrorCount"
    namespace = "MatrixOS/Application"
    value     = "1"
  }
}

# 🌟 Error Rate Alarm
resource "aws_cloudwatch_metric_alarm" "matrixos_high_error_rate" {
  alarm_name          = "matrixos-high-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ErrorCount"
  namespace           = "MatrixOS/Application"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors application error rate"
  alarm_actions       = [aws_sns_topic.matrixos_alerts.arn]
  
  tags = {
    Name        = "MatrixOS High Error Rate Alarm"
    Environment = var.environment
  }
}

# 🌟 Cost Optimization - Budget Alert
resource "aws_budgets_budget" "matrixos_cost_budget" {
  name              = "matrixos-layer0-monthly-budget"
  budget_type       = "COST"
  limit_amount      = "100"
  limit_unit        = "USD"
  time_period_start = "2024-01-01_00:00"
  time_unit         = "MONTHLY"
  
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = ["admin@matrixos-layer0.com"]  # Update with your email
  }
  
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = ["admin@matrixos-layer0.com"]  # Update with your email
  }
  
  tags = {
    Name        = "MatrixOS Layer 0 Cost Budget"
    Environment = var.environment
  }
}

# 🌟 Data Source for Current Region
data "aws_region" "current" {} 

# 🌟 Comprehensive Outputs for Optimized Infrastructure
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "EKS cluster IAM role name"
  value       = module.eks.cluster_iam_role_name
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.matrixos_cluster.name
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.matrixos_cluster.arn
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.matrixos_service.name
}

output "ecs_service_arn" {
  description = "ECS service ARN"
  value       = aws_ecs_service.matrixos_service.id
}

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.matrixos_task.arn
}

output "database_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.matrixos_db.endpoint
}

output "database_name" {
  description = "Database name"
  value       = aws_db_instance.matrixos_db.db_name
}

output "database_port" {
  description = "Database port"
  value       = aws_db_instance.matrixos_db.port
}

output "cache_endpoint" {
  description = "ElastiCache endpoint"
  value       = aws_elasticache_cluster.matrixos_cache.cache_nodes.0.address
}

output "cache_port" {
  description = "ElastiCache port"
  value       = aws_elasticache_cluster.matrixos_cache.cache_nodes.0.port
}

output "load_balancer_dns" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.matrixos_alb.dns_name
}

output "load_balancer_zone_id" {
  description = "Application Load Balancer zone ID"
  value       = aws_lb.matrixos_alb.zone_id
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.matrixos_tg.arn
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "database_subnet_group_name" {
  description = "Database subnet group name"
  value       = aws_db_subnet_group.matrixos_db_subnet_group.name
}

output "cache_subnet_group_name" {
  description = "Cache subnet group name"
  value       = aws_elasticache_subnet_group.matrixos_cache_subnet_group.name
}

output "cloudwatch_dashboard_name" {
  description = "CloudWatch dashboard name"
  value       = aws_cloudwatch_dashboard.matrixos_dashboard.dashboard_name
}

output "cloudwatch_dashboard_arn" {
  description = "CloudWatch dashboard ARN"
  value       = aws_cloudwatch_dashboard.matrixos_dashboard.dashboard_arn
}

output "sns_topic_arn" {
  description = "SNS topic ARN for notifications"
  value       = aws_sns_topic.matrixos_alerts.arn
}

output "xray_group_name" {
  description = "X-Ray group name"
  value       = aws_xray_group.matrixos_tracing.group_name
}

output "xray_group_arn" {
  description = "X-Ray group ARN"
  value       = aws_xray_group.matrixos_tracing.arn
}

output "service_discovery_namespace_id" {
  description = "Service discovery namespace ID"
  value       = aws_service_discovery_private_dns_namespace.matrixos_namespace.id
}

output "service_discovery_service_arn" {
  description = "Service discovery service ARN"
  value       = aws_service_discovery_service.matrixos_service.arn
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = var.ecr_repository_url
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}

output "availability_zones" {
  description = "Availability zones"
  value       = module.vpc.azs
}

output "internet_gateway_id" {
  description = "Internet gateway ID"
  value       = module.vpc.igw_id
}

output "route_table_ids" {
  description = "Route table IDs"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "Private route table IDs"
  value       = module.vpc.private_route_table_ids
}

output "security_group_ids" {
  description = "Security group IDs"
  value = {
    alb          = aws_security_group.alb.id
    ecs_tasks    = aws_security_group.ecs_tasks.id
    database     = aws_security_group.matrixos_db_sg.id
    cache        = aws_security_group.matrixos_cache_sg.id
    cluster      = module.eks.cluster_security_group_id
    node_groups  = module.eks.node_security_group_id
  }
}

output "iam_role_arns" {
  description = "IAM role ARNs"
  value = {
    ecs_execution = aws_iam_role.ecs_execution_role.arn
    ecs_task      = aws_iam_role.ecs_task_role.arn
    rds_monitoring = aws_iam_role.rds_monitoring_role.arn
    ebs_csi       = module.ebs_csi_irsa_role.iam_role_arn
  }
}

output "auto_scaling_target_arn" {
  description = "Auto scaling target ARN"
  value       = aws_appautoscaling_target.matrixos_ecs_target.resource_id
}

output "auto_scaling_policies" {
  description = "Auto scaling policy names"
  value = {
    cpu    = aws_appautoscaling_policy.matrixos_cpu_policy.name
    memory = aws_appautoscaling_policy.matrixos_memory_policy.name
  }
}

output "cloudwatch_alarms" {
  description = "CloudWatch alarm names"
  value = {
    high_cpu        = aws_cloudwatch_metric_alarm.matrixos_high_cpu.alarm_name
    high_memory     = aws_cloudwatch_metric_alarm.matrixos_high_memory.alarm_name
    db_high_cpu     = aws_cloudwatch_metric_alarm.matrixos_db_high_cpu.alarm_name
    cache_high_memory = aws_cloudwatch_metric_alarm.matrixos_cache_high_memory.alarm_name
    high_error_rate = aws_cloudwatch_metric_alarm.matrixos_high_error_rate.alarm_name
  }
}

output "budget_name" {
  description = "Cost budget name"
  value       = aws_budgets_budget.matrixos_cost_budget.name
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.matrixos_logs.name
}

output "parameter_group_names" {
  description = "Parameter group names"
  value = {
    database = aws_db_parameter_group.matrixos_db_pg.name
    cache    = aws_elasticache_parameter_group.matrixos_cache_pg.name
  }
}

output "option_group_name" {
  description = "Database option group name"
  value       = aws_db_option_group.matrixos_db_og.name
}

output "deployment_summary" {
  description = "Complete deployment summary"
  value = {
    infrastructure = {
      vpc_id = module.vpc.vpc_id
      region = data.aws_region.current.name
      environment = var.environment
    }
    compute = {
      eks_cluster = module.eks.cluster_name
      ecs_cluster = aws_ecs_cluster.matrixos_cluster.name
      ecs_service = aws_ecs_service.matrixos_service.name
    }
    storage = {
      database = aws_db_instance.matrixos_db.endpoint
      cache    = aws_elasticache_cluster.matrixos_cache.cache_nodes.0.address
    }
    networking = {
      load_balancer = aws_lb.matrixos_alb.dns_name
      vpc_cidr      = module.vpc.vpc_cidr_block
    }
    monitoring = {
      dashboard = aws_cloudwatch_dashboard.matrixos_dashboard.dashboard_name
      alarms    = length([aws_cloudwatch_metric_alarm.matrixos_high_cpu, aws_cloudwatch_metric_alarm.matrixos_high_memory, aws_cloudwatch_metric_alarm.matrixos_db_high_cpu, aws_cloudwatch_metric_alarm.matrixos_cache_high_memory, aws_cloudwatch_metric_alarm.matrixos_high_error_rate])
      tracing   = aws_xray_group.matrixos_tracing.group_name
    }
    optimization = {
      auto_scaling = aws_appautoscaling_target.matrixos_ecs_target.resource_id
      cost_budget  = aws_budgets_budget.matrixos_cost_budget.name
      spot_instances = "enabled"
    }
  }
} 