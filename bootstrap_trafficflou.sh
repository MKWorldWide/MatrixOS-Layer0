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
