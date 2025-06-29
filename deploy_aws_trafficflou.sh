#!/bin/bash

# =============================================================================
# 🚀 TRAFFICFLOU AWS DEPLOYMENT SCRIPT - LILITH AUTOMATION
# =============================================================================
# Automated deployment of enhanced TrafficFlou system to AWS EC2
# Features: Multi-page GameDin.xyz targeting, Instagram routing, exponential acceleration
# =============================================================================

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="TrafficFlou"
GITHUB_REPO="https://github.com/M-K-World-Wide/TrafficFlou.git"
EC2_INSTANCE_TYPE="t3.medium"
EC2_AMI="ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI
KEY_NAME="trafficflou-key"
# Quantum-detailed: Use only the new, secure security group for TrafficFlou
SECURITY_GROUP_ID="sg-0c4dc86b8c4e9b2ee"  # trafficflou-secure
REGION="us-east-1"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}==============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}==============================================================================${NC}"
}

# Function to check if AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        print_error "AWS CLI is not installed. Please install it first."
        print_status "Installation guide: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
        exit 1
    fi
    print_status "AWS CLI is installed"
}

# Function to check AWS credentials
check_aws_credentials() {
    if ! aws sts get-caller-identity &> /dev/null; then
        print_error "AWS credentials not configured. Please run 'aws configure' first."
        exit 1
    fi
    print_status "AWS credentials are configured"
}

# Function to create EC2 key pair
create_key_pair() {
    print_status "Creating EC2 key pair..."
    
    if aws ec2 describe-key-pairs --key-names "$KEY_NAME" --region "$REGION" &> /dev/null; then
        print_warning "Key pair $KEY_NAME already exists"
    else
        aws ec2 create-key-pair --key-name "$KEY_NAME" --region "$REGION" --query 'KeyMaterial' --output text > "$KEY_NAME.pem"
        chmod 400 "$KEY_NAME.pem"
        print_status "Key pair $KEY_NAME created and saved to $KEY_NAME.pem"
    fi
}

# Function to create security group
create_security_group() {
    print_status "Creating security group..."
    
    if aws ec2 describe-security-groups --group-names "$SECURITY_GROUP_NAME" --region "$REGION" &> /dev/null; then
        print_warning "Security group $SECURITY_GROUP_NAME already exists"
        return
    fi
    
    # Create security group
    SG_ID=$(aws ec2 create-security-group \
        --group-name "$SECURITY_GROUP_NAME" \
        --description "Security group for TrafficFlou" \
        --region "$REGION" \
        --query 'GroupId' --output text)
    
    # Add SSH rule
    aws ec2 authorize-security-group-ingress \
        --group-id "$SG_ID" \
        --protocol tcp \
        --port 22 \
        --cidr 0.0.0.0/0 \
        --region "$REGION"
    
    # Add HTTP rule
    aws ec2 authorize-security-group-ingress \
        --group-id "$SG_ID" \
        --protocol tcp \
        --port 80 \
        --cidr 0.0.0.0/0 \
        --region "$REGION"
    
    # Add HTTPS rule
    aws ec2 authorize-security-group-ingress \
        --group-id "$SG_ID" \
        --protocol tcp \
        --port 443 \
        --cidr 0.0.0.0/0 \
        --region "$REGION"
    
    print_status "Security group $SECURITY_GROUP_NAME created with ID: $SG_ID"
}

# Function to launch EC2 instance
launch_ec2_instance() {
    print_status "Launching EC2 instance..."
    
    # Get security group ID
    SG_ID=$(aws ec2 describe-security-groups --group-names "$SECURITY_GROUP_NAME" --region "$REGION" --query 'SecurityGroups[0].GroupId' --output text)
    
    # Launch instance
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$EC2_AMI" \
        --count 1 \
        --instance-type "$EC2_INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SECURITY_GROUP_ID" \
        --region "$REGION" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$PROJECT_NAME}]" \
        --query 'Instances[0].InstanceId' --output text)
    
    print_status "EC2 instance launched with ID: $INSTANCE_ID"
    
    # Wait for instance to be running
    print_status "Waiting for instance to be running..."
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"
    
    # Get public IP
    PUBLIC_IP=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --region "$REGION" \
        --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    
    print_status "Instance is running with public IP: $PUBLIC_IP"
    echo "$INSTANCE_ID" > .instance_id
    echo "$PUBLIC_IP" > .public_ip
}

# Function to wait for SSH to be available
wait_for_ssh() {
    print_status "Waiting for SSH to be available..."
    PUBLIC_IP=$(cat .public_ip)
    
    while ! nc -z "$PUBLIC_IP" 22; do
        sleep 5
    done
    
    # Additional wait for SSH service to be fully ready
    sleep 30
    print_status "SSH is available"
}

# Function to create bootstrap script for EC2
create_bootstrap_script() {
    cat > bootstrap_trafficflou.sh << 'EOF'
#!/bin/bash

# =============================================================================
# 🚀 TRAFFICFLOU EC2 BOOTSTRAP SCRIPT
# =============================================================================

set -e

# Update system
echo "🔄 Updating system packages..."
sudo yum update -y

# Install Python 3.9 and pip
echo "🐍 Installing Python 3.9..."
sudo yum install -y python3 python3-pip git

# Install additional dependencies
echo "📦 Installing additional dependencies..."
sudo yum install -y gcc python3-devel

# Create project directory
echo "📁 Creating project directory..."
mkdir -p /home/ec2-user/TrafficFlou
cd /home/ec2-user/TrafficFlou

# Clone repository
echo "📥 Cloning TrafficFlou repository..."
git clone https://github.com/M-K-World-Wide/TrafficFlou.git .

# Create virtual environment
echo "🔧 Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install --upgrade pip
pip install aiohttp fake-useragent faker numpy asyncio

# Create systemd service for continuous operation
echo "⚙️ Creating systemd service..."
sudo tee /etc/systemd/system/trafficflou.service > /dev/null << 'SERVICE_EOF'
[Unit]
Description=TrafficFlou Enhanced Traffic Generator
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/TrafficFlou
Environment=PATH=/home/ec2-user/TrafficFlou/venv/bin
ExecStart=/home/ec2-user/TrafficFlou/venv/bin/python start_gamedin_traffic.py
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
SERVICE_EOF

# Enable and start service
echo "🚀 Enabling and starting TrafficFlou service..."
sudo systemctl daemon-reload
sudo systemctl enable trafficflou
sudo systemctl start trafficflou

# Create monitoring script
cat > monitor_trafficflou.sh << 'MONITOR_EOF'
#!/bin/bash
echo "📊 TrafficFlou Status:"
sudo systemctl status trafficflou --no-pager
echo ""
echo "📈 Recent logs:"
sudo journalctl -u trafficflou -n 20 --no-pager
MONITOR_EOF

chmod +x monitor_trafficflou.sh

# Create log viewer
cat > view_logs.sh << 'LOG_EOF'
#!/bin/bash
sudo journalctl -u trafficflou -f
LOG_EOF

chmod +x view_logs.sh

echo "✅ TrafficFlou bootstrap completed successfully!"
echo "🚀 Service is running and will auto-restart on failure"
echo "📊 Use './monitor_trafficflou.sh' to check status"
echo "📝 Use './view_logs.sh' to view live logs"
EOF

    chmod +x bootstrap_trafficflou.sh
}

# Function to deploy to EC2
deploy_to_ec2() {
    print_status "Deploying TrafficFlou to EC2..."
    
    PUBLIC_IP=$(cat .public_ip)
    
    # Copy bootstrap script to EC2
    scp -i "$KEY_NAME.pem" -o StrictHostKeyChecking=no bootstrap_trafficflou.sh ec2-user@"$PUBLIC_IP":~/
    
    # Run bootstrap script on EC2
    ssh -i "$KEY_NAME.pem" -o StrictHostKeyChecking=no ec2-user@"$PUBLIC_IP" "chmod +x bootstrap_trafficflou.sh && ./bootstrap_trafficflou.sh"
    
    print_status "Deployment completed successfully!"
}

# Function to show deployment status
show_status() {
    print_header "DEPLOYMENT STATUS"
    
    if [ -f .instance_id ] && [ -f .public_ip ]; then
        INSTANCE_ID=$(cat .instance_id)
        PUBLIC_IP=$(cat .public_ip)
        
        print_status "Instance ID: $INSTANCE_ID"
        print_status "Public IP: $PUBLIC_IP"
        print_status "SSH Command: ssh -i $KEY_NAME.pem ec2-user@$PUBLIC_IP"
        
        # Check instance status
        INSTANCE_STATE=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --region "$REGION" --query 'Reservations[0].Instances[0].State.Name' --output text)
        print_status "Instance State: $INSTANCE_STATE"
        
        if [ "$INSTANCE_STATE" = "running" ]; then
            print_status "✅ Instance is running"
            
            # Check if we can connect
            if nc -z "$PUBLIC_IP" 22 2>/dev/null; then
                print_status "✅ SSH is accessible"
                
                # Check service status
                print_status "Checking TrafficFlou service status..."
                ssh -i "$KEY_NAME.pem" -o StrictHostKeyChecking=no -o ConnectTimeout=10 ec2-user@"$PUBLIC_IP" "sudo systemctl is-active trafficflou" 2>/dev/null && {
                    print_status "✅ TrafficFlou service is running"
                } || {
                    print_warning "⚠️ TrafficFlou service is not running"
                }
            else
                print_warning "⚠️ SSH is not accessible yet"
            fi
        else
            print_warning "⚠️ Instance is not running (State: $INSTANCE_STATE)"
        fi
    else
        print_warning "No deployment information found"
    fi
}

# Function to stop and terminate instance
cleanup() {
    print_header "CLEANUP"
    
    if [ -f .instance_id ]; then
        INSTANCE_ID=$(cat .instance_id)
        print_status "Terminating EC2 instance: $INSTANCE_ID"
        aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
        rm -f .instance_id .public_ip
        print_status "Instance termination initiated"
    else
        print_warning "No instance ID found"
    fi
}

# Function to show help
show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  deploy     - Full deployment (create resources and deploy)"
    echo "  status     - Show deployment status"
    echo "  cleanup    - Terminate EC2 instance and cleanup"
    echo "  help       - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 deploy    # Deploy TrafficFlou to AWS"
    echo "  $0 status    # Check deployment status"
    echo "  $0 cleanup   # Clean up resources"
}

# Main execution
main() {
    print_header "🚀 TRAFFICFLOU AWS DEPLOYMENT - LILITH AUTOMATION"
    
    case "${1:-deploy}" in
        "deploy")
            check_aws_cli
            check_aws_credentials
            create_key_pair
            create_security_group
            launch_ec2_instance
            wait_for_ssh
            create_bootstrap_script
            deploy_to_ec2
            show_status
            ;;
        "status")
            show_status
            ;;
        "cleanup")
            cleanup
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@" 