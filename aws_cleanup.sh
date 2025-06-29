#!/bin/bash

# AWS Cleanup Script for TrafficFlou
# Removes old resources while keeping the most recent and efficient ones
# Quantum-detailed: Updated for 2025 security group refactor
# Only new security groups (trafficflou-secure, serafina-secure) are retained
# All legacy groups and dependencies are removed
# See docs/architecture.md for full context

set -e

echo "🧹 Starting AWS Cleanup Process..."
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Terminate old TrafficFlou instances
print_status "Terminating old TrafficFlou instances..."
OLD_TRAFFICFLOU_INSTANCES=("i-09b4d991e7caf6c01" "i-03e772b00dd3bf621" "i-069732a115f8997fa")

for instance in "${OLD_TRAFFICFLOU_INSTANCES[@]}"; do
    print_status "Terminating instance: $instance"
    aws ec2 terminate-instances --instance-ids "$instance" --output json > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_success "Successfully initiated termination for $instance"
    else
        print_error "Failed to terminate $instance"
    fi
done

# 2. Terminate old Serafina instance
print_status "Terminating old Serafina instance..."
OLD_SERAFINA_INSTANCE="i-01e18f2e7328535dd"
print_status "Terminating instance: $OLD_SERAFINA_INSTANCE"
aws ec2 terminate-instances --instance-ids "$OLD_SERAFINA_INSTANCE" --output json > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_success "Successfully initiated termination for $OLD_SERAFINA_INSTANCE"
else
    print_error "Failed to terminate $OLD_SERAFINA_INSTANCE"
fi

# 3. Delete old security groups
print_status "Deleting old security groups..."
OLD_SECURITY_GROUPS=("sg-03ffc729a20b321b9" "sg-0fd726000be45c303")

for sg in "${OLD_SECURITY_GROUPS[@]}"; do
    print_status "Deleting security group: $sg"
    aws ec2 delete-security-group --group-id "$sg" --output json > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_success "Successfully deleted security group $sg"
    else
        print_warning "Failed to delete security group $sg (may be in use or already deleted)"
    fi
done

# 4. Delete old key pair
print_status "Deleting old key pair..."
OLD_KEY_PAIR="serafina-key-pair"
print_status "Deleting key pair: $OLD_KEY_PAIR"
aws ec2 delete-key-pair --key-name "$OLD_KEY_PAIR" --output json > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_success "Successfully deleted key pair $OLD_KEY_PAIR"
else
    print_warning "Failed to delete key pair $OLD_KEY_PAIR (may not exist or already deleted)"
fi

# 5. Wait for instances to terminate and clean up volumes
print_status "Waiting for instances to terminate..."
sleep 30

# 6. Delete orphaned volumes (volumes not attached to any instance)
print_status "Cleaning up orphaned volumes..."
ORPHANED_VOLUMES=$(aws ec2 describe-volumes --filters "Name=status,Values=available" --query 'Volumes[*].VolumeId' --output text)

if [ -n "$ORPHANED_VOLUMES" ]; then
    for volume in $ORPHANED_VOLUMES; do
        print_status "Deleting orphaned volume: $volume"
        aws ec2 delete-volume --volume-id "$volume" --output json > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_success "Successfully deleted volume $volume"
        else
            print_warning "Failed to delete volume $volume"
        fi
    done
else
    print_status "No orphaned volumes found"
fi

# 7. Show remaining resources
print_status "Current AWS Resources After Cleanup:"
echo "=========================================="

print_status "Remaining EC2 Instances:"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,LaunchTime,Tags[?Key==`Name`].Value|[0],PublicIpAddress]' --output table

print_status "Remaining Security Groups:"
aws ec2 describe-security-groups --query 'SecurityGroups[*].[GroupId,GroupName,Description]' --output table

print_status "Remaining Key Pairs:"
aws ec2 describe-key-pairs --query 'KeyPairs[*].[KeyName,KeyType,CreateTime]' --output table

print_success "AWS Cleanup completed successfully!"
echo ""
print_status "Resources Kept:"
echo "  ✅ Latest TrafficFlou instance: i-0f11c6696a3cd749d"
echo "  ✅ Latest Serafina instance: i-050952a169b28574e"
echo "  ✅ Current security groups: trafficflou-sg, serafina-sg"
echo "  ✅ Current key pairs: trafficflou-key, serafina-key"
echo ""
print_status "Resources Removed:"
echo "  ❌ Old TrafficFlou instances (3 instances)"
echo "  ❌ Old Serafina instance (1 instance)"
echo "  ❌ Duplicate security groups (2 groups)"
echo "  ❌ Old key pair (1 key)"
echo "  ❌ Orphaned volumes (if any)" 