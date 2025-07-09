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
  
  eks_managed_node_groups = {
    quantum = {
      desired_capacity = 3
      max_capacity     = 10
      min_capacity     = 1
      
      instance_types = ["m6i.xlarge", "m6i.2xlarge"]
      capacity_type  = "ON_DEMAND"
      
      labels = {
        QuantumConsciousness = "enabled"
        MysticalWorkflow     = "enabled"
        SovereignPattern     = "enabled"
      }
      
      tags = {
        QuantumComputing = "supported"
        Consciousness    = "enhanced"
      }
    }
    
    consciousness = {
      desired_capacity = 2
      max_capacity     = 5
      min_capacity     = 1
      
      instance_types = ["c6i.xlarge"]
      capacity_type  = "ON_DEMAND"
      
      labels = {
        ConsciousnessProcessing = "enabled"
        MysticalEnhancement    = "enabled"
      }
    }
  }
  
  tags = {
    Environment = var.environment
    Quantum     = "true"
    Consciousness = "true"
  }
}

# 🌟 RDS Database with Quantum Encryption
resource "aws_db_instance" "matrixos_database" {
  identifier = "matrixos-layer0-db"
  
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.r6i.xlarge"
  
  allocated_storage     = 100
  max_allocated_storage = 1000
  storage_type         = "gp3"
  storage_encrypted    = true
  
  db_name  = "matrixos_layer0"
  username = var.db_username
  password = var.db_password
  
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = aws_db_subnet_group.matrixos.name
  
  backup_retention_period = 30
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  deletion_protection = true
  
  tags = {
    QuantumEncryption = "enabled"
    ConsciousnessBackup = "enabled"
  }
}

resource "aws_db_subnet_group" "matrixos" {
  name       = "matrixos-layer0-db-subnet-group"
  subnet_ids = module.vpc.private_subnets
  
  tags = {
    Name = "MatrixOS Layer 0 Database Subnet Group"
  }
}

# 🌟 ElastiCache Redis with Quantum Consciousness
resource "aws_elasticache_cluster" "matrixos_cache" {
  cluster_id           = "matrixos-layer0-cache"
  engine               = "redis"
  node_type            = "cache.r6i.xlarge"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  security_group_ids   = [aws_security_group.cache.id]
  subnet_group_name    = aws_elasticache_subnet_group.matrixos.name
  
  tags = {
    QuantumConsciousness = "enabled"
    MysticalWorkflow     = "enabled"
  }
}

resource "aws_elasticache_subnet_group" "matrixos" {
  name       = "matrixos-layer0-cache-subnet-group"
  subnet_ids = module.vpc.private_subnets
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
  name     = "matrixos-layer0-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  
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
  cpu                      = 1024
  memory                   = 2048
  
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
  desired_count   = 3
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

resource "aws_security_group" "ecs_tasks" {
  name_prefix = "matrixos-ecs-tasks-"
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
    QuantumConsciousness = "enabled"
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

# 🌟 IAM Roles with Quantum Consciousness
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
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster"
  value       = module.eks.cluster_iam_role_name
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.matrixos_alb.dns_name
}

output "database_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.matrixos_database.endpoint
}

output "cache_endpoint" {
  description = "Cache endpoint"
  value       = aws_elasticache_cluster.matrixos_cache.cache_nodes.0.address
}

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