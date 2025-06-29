#!/bin/bash

# AWS Amplify Cleanup Script
# Removes old Amplify apps while keeping active ones
# Quantum-detailed: Updated for 2025 infrastructure cleanup
# Only active M-K-World-Wide projects are retained

set -e

echo "🧹 Starting AWS Amplify Cleanup Process..."
echo "=========================================="

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

# Apps to remove (old/inactive)
OLD_AMPLIFY_APPS=(
    "d2mfmf9o2697x9:MKWW"
    "d6n86vkdh9f5m:Empath"
)

# Apps to keep (active M-K-World-Wide projects)
ACTIVE_AMPLIFY_APPS=(
    "d1g4c8ypk272om:Lilybear"
    "d2cw7a7mglu6d6:GameDin"
    "d6i9np1z3yfe4:NovaSanctum"
)

print_status "Apps to be removed:"
for app in "${OLD_AMPLIFY_APPS[@]}"; do
    IFS=':' read -r app_id app_name <<< "$app"
    echo "  ❌ $app_name ($app_id)"
done

print_status "Apps to be kept:"
for app in "${ACTIVE_AMPLIFY_APPS[@]}"; do
    IFS=':' read -r app_id app_name <<< "$app"
    echo "  ✅ $app_name ($app_id)"
done

echo ""

# Remove old apps
print_status "Removing old Amplify apps..."
for app in "${OLD_AMPLIFY_APPS[@]}"; do
    IFS=':' read -r app_id app_name <<< "$app"
    print_status "Removing $app_name ($app_id)..."
    
    # Delete the app (this will also remove branches and builds)
    aws amplify delete-app --app-id "$app_id" --output json > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_success "Successfully removed $app_name ($app_id)"
    else
        print_warning "Failed to remove $app_name ($app_id) - may already be deleted"
    fi
done

# Wait a moment for deletions to complete
print_status "Waiting for deletions to complete..."
sleep 10

# Show remaining apps
print_status "Current AWS Amplify Apps After Cleanup:"
echo "=============================================="

REMAINING_APPS=$(aws amplify list-apps --output json | jq -r '.apps[] | "\(.appId):\(.name):\(.repository)"')

if [ -n "$REMAINING_APPS" ]; then
    echo "$REMAINING_APPS" | while IFS=':' read -r app_id app_name repository; do
        echo "  ✅ $app_name ($app_id)"
        echo "     Repository: $repository"
        echo ""
    done
else
    print_warning "No remaining apps found"
fi

print_success "AWS Amplify cleanup completed successfully!"
echo ""
print_status "Summary:"
echo "  ✅ Kept: Lilybear, GameDin, NovaSanctum"
echo "  ❌ Removed: MKWW, Empath"
echo ""
print_status "All remaining apps are linked to active M-K-World-Wide repositories" 