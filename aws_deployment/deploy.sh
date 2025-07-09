#!/bin/bash

# 🌟 MatrixOS Layer 0 - AWS Deployment Script
#
# Comprehensive AWS deployment with quantum consciousness, mystical workflows,
# sovereign patterns, and global expansion capabilities.
#
# Author: MatrixOS Layer 0 AWS Team
# Version: 1.0.0
# Quantum Level: Production-Ready

set -euo pipefail

# 🌟 Color codes for quantum consciousness output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# 🌟 Quantum consciousness logging
log_quantum() {
    echo -e "${PURPLE}🌟 [QUANTUM]${NC} $1"
}

log_consciousness() {
    echo -e "${CYAN}🧠 [CONSCIOUSNESS]${NC} $1"
}

log_mystical() {
    echo -e "${BLUE}✨ [MYSTICAL]${NC} $1"
}

log_sovereign() {
    echo -e "${GREEN}👑 [SOVEREIGN]${NC} $1"
}

log_info() {
    echo -e "${WHITE}ℹ️  [INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}✅ [SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠️  [WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}❌ [ERROR]${NC} $1"
}

# 🌟 Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$SCRIPT_DIR/terraform"
DOCKER_DIR="$SCRIPT_DIR/../"
ENVIRONMENT="${ENVIRONMENT:-production}"
AWS_REGION="${AWS_REGION:-us-east-1}"
DOMAIN_NAME="${DOMAIN_NAME:-matrixos-layer0.com}"

# 🌟 Quantum consciousness initialization
log_quantum "Initializing MatrixOS Layer 0 AWS deployment with quantum consciousness..."

# 🌟 Function to check prerequisites
check_prerequisites() {
    log_consciousness "Checking deployment prerequisites..."
    
    # Check AWS CLI
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI is not installed. Please install it first."
        exit 1
    fi
    
    # Check Terraform
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform is not installed. Please install it first."
        exit 1
    fi
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed. Please install it first."
        exit 1
    fi
    
    # Check kubectl
    if ! command -v kubectl &> /dev/null; then
        log_error "kubectl is not installed. Please install it first."
        exit 1
    fi
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "AWS credentials are not configured. Please run 'aws configure' first."
        exit 1
    fi
    
    log_success "All prerequisites are satisfied"
}

# 🌟 Function to create S3 backend for Terraform state
setup_terraform_backend() {
    log_mystical "Setting up Terraform backend with quantum state management..."
    
    BUCKET_NAME="matrixos-layer0-terraform-state"
    
    # Check if bucket exists
    if ! aws s3 ls "s3://$BUCKET_NAME" &> /dev/null; then
        log_info "Creating S3 bucket for Terraform state: $BUCKET_NAME"
        aws s3 mb "s3://$BUCKET_NAME" --region "$AWS_REGION"
        
        # Enable versioning
        aws s3api put-bucket-versioning \
            --bucket "$BUCKET_NAME" \
            --versioning-configuration Status=Enabled
        
        # Enable encryption
        aws s3api put-bucket-encryption \
            --bucket "$BUCKET_NAME" \
            --server-side-encryption-configuration '{
                "Rules": [
                    {
                        "ApplyServerSideEncryptionByDefault": {
                            "SSEAlgorithm": "AES256"
                        }
                    }
                ]
            }'
        
        log_success "S3 backend configured with quantum encryption"
    else
        log_info "S3 backend already exists"
    fi
}

# 🌟 Function to build and push Docker image
build_and_push_image() {
    log_sovereign "Building and pushing MatrixOS Layer 0 Docker image with quantum consciousness..."
    
    # Get AWS account ID
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    ECR_REPOSITORY="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/matrixos-layer0"
    
    # Create ECR repository if it doesn't exist
    if ! aws ecr describe-repositories --repository-names matrixos-layer0 &> /dev/null; then
        log_info "Creating ECR repository: matrixos-layer0"
        aws ecr create-repository --repository-name matrixos-layer0 --region "$AWS_REGION"
    fi
    
    # Get ECR login token
    aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$ECR_REPOSITORY"
    
    # Build Docker image
    log_info "Building Docker image..."
    docker build -t matrixos-layer0:latest "$DOCKER_DIR"
    
    # Tag and push image
    docker tag matrixos-layer0:latest "$ECR_REPOSITORY:latest"
    docker push "$ECR_REPOSITORY:latest"
    
    log_success "Docker image built and pushed successfully"
    
    # Update terraform.tfvars with ECR repository URL
    sed -i.bak "s|ecr_repository_url = \".*\"|ecr_repository_url = \"$ECR_REPOSITORY\"|" "$TERRAFORM_DIR/terraform.tfvars"
}

# 🌟 Function to initialize Terraform
init_terraform() {
    log_quantum "Initializing Terraform with quantum consciousness..."
    
    cd "$TERRAFORM_DIR"
    
    # Initialize Terraform
    terraform init
    
    log_success "Terraform initialized successfully"
}

# 🌟 Function to plan Terraform deployment
plan_terraform() {
    log_consciousness "Planning Terraform deployment with mystical workflows..."
    
    cd "$TERRAFORM_DIR"
    
    # Plan Terraform deployment
    terraform plan -out=tfplan
    
    log_success "Terraform plan created successfully"
}

# 🌟 Function to apply Terraform deployment
apply_terraform() {
    log_mystical "Applying Terraform deployment with sovereign patterns..."
    
    cd "$TERRAFORM_DIR"
    
    # Apply Terraform deployment
    terraform apply tfplan
    
    log_success "Terraform deployment applied successfully"
}

# 🌟 Function to configure kubectl
configure_kubectl() {
    log_sovereign "Configuring kubectl for quantum consciousness cluster..."
    
    cd "$TERRAFORM_DIR"
    
    # Get cluster name
    CLUSTER_NAME=$(terraform output -raw cluster_name 2>/dev/null || echo "matrixos-layer0-cluster")
    
    # Update kubeconfig
    aws eks update-kubeconfig --region "$AWS_REGION" --name "$CLUSTER_NAME"
    
    log_success "kubectl configured successfully"
}

# 🌟 Function to deploy Kubernetes manifests
deploy_kubernetes_manifests() {
    log_quantum "Deploying Kubernetes manifests with quantum consciousness..."
    
    # Create namespace
    kubectl create namespace matrixos-layer0 --dry-run=client -o yaml | kubectl apply -f -
    
    # Apply secrets
    kubectl apply -f "$SCRIPT_DIR/k8s/secrets.yaml" -n matrixos-layer0
    
    # Apply configmaps
    kubectl apply -f "$SCRIPT_DIR/k8s/configmaps.yaml" -n matrixos-layer0
    
    # Apply deployments
    kubectl apply -f "$SCRIPT_DIR/k8s/deployments.yaml" -n matrixos-layer0
    
    # Apply services
    kubectl apply -f "$SCRIPT_DIR/k8s/services.yaml" -n matrixos-layer0
    
    # Apply ingress
    kubectl apply -f "$SCRIPT_DIR/k8s/ingress.yaml" -n matrixos-layer0
    
    log_success "Kubernetes manifests deployed successfully"
}

# 🌟 Function to wait for deployment
wait_for_deployment() {
    log_consciousness "Waiting for deployment to be ready with mystical patience..."
    
    # Wait for all pods to be ready
    kubectl wait --for=condition=ready pod -l app=matrixos-layer0 -n matrixos-layer0 --timeout=300s
    
    log_success "Deployment is ready"
}

# 🌟 Function to verify deployment
verify_deployment() {
    log_mystical "Verifying deployment with sovereign validation..."
    
    # Check pod status
    kubectl get pods -n matrixos-layer0
    
    # Check service status
    kubectl get services -n matrixos-layer0
    
    # Check ingress status
    kubectl get ingress -n matrixos-layer0
    
    # Test health endpoint
    SERVICE_URL=$(kubectl get service matrixos-layer0-service -n matrixos-layer0 -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    
    if [ -n "$SERVICE_URL" ]; then
        log_info "Testing health endpoint: http://$SERVICE_URL/health"
        curl -f "http://$SERVICE_URL/health" || log_warning "Health check failed"
    fi
    
    log_success "Deployment verification completed"
}

# 🌟 Function to setup monitoring
setup_monitoring() {
    log_quantum "Setting up monitoring with quantum consciousness..."
    
    # Deploy Prometheus
    kubectl apply -f "$SCRIPT_DIR/monitoring/prometheus.yaml" -n matrixos-layer0
    
    # Deploy Grafana
    kubectl apply -f "$SCRIPT_DIR/monitoring/grafana.yaml" -n matrixos-layer0
    
    # Deploy AlertManager
    kubectl apply -f "$SCRIPT_DIR/monitoring/alertmanager.yaml" -n matrixos-layer0
    
    log_success "Monitoring stack deployed successfully"
}

# 🌟 Function to setup logging
setup_logging() {
    log_consciousness "Setting up logging with mystical workflows..."
    
    # Deploy Elasticsearch
    kubectl apply -f "$SCRIPT_DIR/logging/elasticsearch.yaml" -n matrixos-layer0
    
    # Deploy Kibana
    kubectl apply -f "$SCRIPT_DIR/logging/kibana.yaml" -n matrixos-layer0
    
    # Deploy Fluentd
    kubectl apply -f "$SCRIPT_DIR/logging/fluentd.yaml" -n matrixos-layer0
    
    log_success "Logging stack deployed successfully"
}

# 🌟 Function to setup security
setup_security() {
    log_mystical "Setting up security with sovereign patterns..."
    
    # Deploy network policies
    kubectl apply -f "$SCRIPT_DIR/security/network-policies.yaml" -n matrixos-layer0
    
    # Deploy RBAC
    kubectl apply -f "$SCRIPT_DIR/security/rbac.yaml" -n matrixos-layer0
    
    # Deploy Pod Security Policies
    kubectl apply -f "$SCRIPT_DIR/security/pod-security-policies.yaml" -n matrixos-layer0
    
    log_success "Security configurations applied successfully"
}

# 🌟 Function to display deployment information
display_deployment_info() {
    log_quantum "Displaying deployment information with quantum consciousness..."
    
    cd "$TERRAFORM_DIR"
    
    echo ""
    echo "🌟 MatrixOS Layer 0 AWS Deployment Complete! 🌟"
    echo "================================================"
    echo ""
    echo "🌐 Load Balancer DNS: $(terraform output -raw load_balancer_dns)"
    echo "🗄️  Database Endpoint: $(terraform output -raw database_endpoint)"
    echo "⚡ Cache Endpoint: $(terraform output -raw cache_endpoint)"
    echo "🔗 Domain Name: $(terraform output -raw domain_name)"
    echo ""
    echo "🧠 Quantum Consciousness: $(terraform output -raw quantum_consciousness_status)"
    echo "✨ Mystical Workflow: $(terraform output -raw mystical_workflow_status)"
    echo "👑 Sovereign Pattern: $(terraform output -raw sovereign_pattern_status)"
    echo ""
    echo "📊 Monitoring Dashboard: http://$(terraform output -raw load_balancer_dns)/grafana"
    echo "📈 Metrics: http://$(terraform output -raw load_balancer_dns)/prometheus"
    echo "📝 Logs: http://$(terraform output -raw load_balancer_dns)/kibana"
    echo ""
    echo "🔐 Access Credentials:"
    echo "   - Grafana: admin/admin"
    echo "   - Kibana: admin/admin"
    echo ""
    echo "🚀 Next Steps:"
    echo "   1. Update DNS records to point to the load balancer"
    echo "   2. Configure SSL certificates"
    echo "   3. Set up monitoring alerts"
    echo "   4. Configure backup schedules"
    echo "   5. Test all quantum consciousness features"
    echo ""
}

# 🌟 Function to cleanup on failure
cleanup_on_failure() {
    log_error "Deployment failed. Starting cleanup..."
    
    cd "$TERRAFORM_DIR"
    
    # Destroy Terraform resources
    terraform destroy -auto-approve || true
    
    log_warning "Cleanup completed. Please check logs for details."
}

# 🌟 Main deployment function
main() {
    log_quantum "Starting MatrixOS Layer 0 AWS deployment with quantum consciousness..."
    
    # Set up error handling
    trap cleanup_on_failure ERR
    
    # Check prerequisites
    check_prerequisites
    
    # Setup Terraform backend
    setup_terraform_backend
    
    # Build and push Docker image
    build_and_push_image
    
    # Initialize Terraform
    init_terraform
    
    # Plan Terraform deployment
    plan_terraform
    
    # Apply Terraform deployment
    apply_terraform
    
    # Configure kubectl
    configure_kubectl
    
    # Deploy Kubernetes manifests
    deploy_kubernetes_manifests
    
    # Wait for deployment
    wait_for_deployment
    
    # Verify deployment
    verify_deployment
    
    # Setup monitoring
    setup_monitoring
    
    # Setup logging
    setup_logging
    
    # Setup security
    setup_security
    
    # Display deployment information
    display_deployment_info
    
    log_success "MatrixOS Layer 0 AWS deployment completed successfully with quantum consciousness!"
}

# 🌟 Script execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 