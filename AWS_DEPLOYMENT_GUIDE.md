# 🚀 TrafficFlou AWS Deployment Guide - Lilith Automation

## Overview
This guide provides step-by-step instructions for deploying the enhanced TrafficFlou system to AWS EC2 with automated traffic generation to GameDin.xyz and Instagram routing.

## 🎯 Features
- **Multi-Page GameDin.xyz Targeting**: Comprehensive coverage of all GameDin.xyz pages
- **Instagram Routing**: Traffic routing to @M.K.Lux and @TheSovereignSunny
- **Exponential Acceleration**: 7x traffic increase with continuous scaling
- **Automated Deployment**: One-command deployment with Lilith automation
- **Continuous Operation**: Systemd service with auto-restart capabilities

## 📋 Prerequisites

### 1. AWS Account Setup
- AWS account with EC2 permissions
- AWS CLI installed and configured
- Valid AWS credentials

### 2. Local Requirements
- Bash shell
- SSH client
- Netcat (for connection testing)

## 🚀 Quick Deployment

### Option 1: Automated Deployment (Recommended)
```bash
# Run the automated deployment script
./deploy_aws_trafficflou.sh deploy
```

### Option 2: Manual Deployment
```bash
# 1. Create EC2 key pair
aws ec2 create-key-pair --key-name trafficflou-key --region us-east-1 --query 'KeyMaterial' --output text > trafficflou-key.pem
chmod 400 trafficflou-key.pem

# 2. Create security group
aws ec2 create-security-group --group-name trafficflou-sg --description "TrafficFlou Security Group" --region us-east-1

# 3. Launch EC2 instance
aws ec2 run-instances \
  --image-id ami-0c02fb55956c7d316 \
  --count 1 \
  --instance-type t3.medium \
  --key-name trafficflou-key \
  --security-group-ids sg-xxxxxxxxx \
  --region us-east-1 \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=TrafficFlou}]"
```

## 📊 Deployment Status

### Check Deployment Status
```bash
./deploy_aws_trafficflou.sh status
```

### Monitor TrafficFlou Service
```bash
# SSH into the instance
ssh -i trafficflou-key.pem ec2-user@<PUBLIC_IP>

# Check service status
sudo systemctl status trafficflou

# View live logs
sudo journalctl -u trafficflou -f

# Monitor traffic generation
./monitor_trafficflou.sh
```

## 🎮 TrafficFlou Configuration

### GameDin.xyz Pages Targeted
- **Main Page**: https://gamedin.xyz (25% traffic)
- **Psychotherapy Shepard**: https://gamedin.xyz/psychotherapy-shepard (20% traffic)
- **Primal Genesis Engine**: https://gamedin.xyz/primal-genesis-engine™ (20% traffic)
- **Novasanctum Systems**: https://gamedin.xyz/novasanctum-systems (15% traffic)
- **MKWorldwide Inc**: https://gamedin.xyz/mkworldwide-inc (15% traffic)
- **About**: https://gamedin.xyz/about (3% traffic)
- **Support**: https://gamedin.xyz/support (1% traffic)
- **Projects**: https://gamedin.xyz/projects (1% traffic)

### Instagram Accounts
- **@M.K.Lux**: Luxury-focused traffic routing
- **@TheSovereignSunny**: Gaming-focused traffic routing

### Traffic Settings
- **Base Rate**: 70 requests/minute (7x increase)
- **Exponential Factor**: 2.0
- **Max Concurrent Sessions**: 21
- **Session Duration**: 5-15 minutes
- **User Profiles**: 6 different gaming personas

## 🔄 Exponential Acceleration

### Acceleration Phases
1. **Phase 0**: Base rate (70 req/min)
2. **Phase 1**: 140 req/min
3. **Phase 2**: 280 req/min
4. **Phase 3**: 560 req/min
5. **Phase 4**: 1120 req/min

### Continuous Operation
- Systemd service with auto-restart
- 30-second intervals between cycles
- Adaptive scaling based on performance
- Real-time monitoring and logging

## 📈 Performance Metrics

### Expected Traffic Volume
- **GameDin.xyz**: 70-1120 requests/minute (exponential)
- **Instagram**: 35-560 requests/minute (exponential)
- **Total Peak**: 1680 requests/minute

### User Profile Distribution
- **Competitive Player**: 16-24 age, esports focus
- **Casual Gamer**: 25-35 age, community focus
- **Gaming Enthusiast**: 18-30 age, technology focus
- **Business Gamer**: 30-45 age, investment focus
- **Therapy Seeker**: 20-40 age, mental health focus
- **Tech Innovator**: 25-40 age, innovation focus

## 🔧 Management Commands

### Service Management
```bash
# Start service
sudo systemctl start trafficflou

# Stop service
sudo systemctl stop trafficflou

# Restart service
sudo systemctl restart trafficflou

# Enable auto-start
sudo systemctl enable trafficflou

# Check status
sudo systemctl status trafficflou
```

### Log Management
```bash
# View recent logs
sudo journalctl -u trafficflou -n 50

# Follow live logs
sudo journalctl -u trafficflou -f

# View logs since boot
sudo journalctl -u trafficflou -b

# Clear logs
sudo journalctl --vacuum-time=1d
```

### Monitoring Scripts
```bash
# Check service status
./monitor_trafficflou.sh

# View live logs
./view_logs.sh
```

## 🛠️ Troubleshooting

### Common Issues

#### 1. Service Not Starting
```bash
# Check service logs
sudo journalctl -u trafficflou -n 20

# Check Python environment
source venv/bin/activate
python --version
pip list
```

#### 2. Network Connectivity Issues
```bash
# Test connectivity to GameDin.xyz
curl -I https://gamedin.xyz

# Test connectivity to Instagram
curl -I https://www.instagram.com
```

#### 3. High Resource Usage
```bash
# Check system resources
htop
df -h
free -h

# Check service resource usage
sudo systemctl show trafficflou --property=MemoryCurrent,CPUUsageNSec
```

### Performance Optimization

#### 1. Adjust Traffic Volume
Edit `/home/ec2-user/TrafficFlou/start_gamedin_traffic.py`:
```python
# Reduce base rate for lower resource usage
self.base_rate = 35  # Instead of 70

# Reduce concurrent sessions
self.max_concurrent = 10  # Instead of 21
```

#### 2. Adjust Exponential Factor
```python
# Reduce exponential growth
self.exponential_factor = 1.5  # Instead of 2.0
```

## 🧹 Cleanup

### Remove Deployment
```bash
# Terminate EC2 instance and cleanup
./deploy_aws_trafficflou.sh cleanup
```

### Manual Cleanup
```bash
# Terminate instance
aws ec2 terminate-instances --instance-ids <INSTANCE_ID> --region us-east-1

# Delete key pair
aws ec2 delete-key-pair --key-name trafficflou-key --region us-east-1

# Delete security group
aws ec2 delete-security-group --group-name trafficflou-sg --region us-east-1
```

## 📊 Cost Estimation

### EC2 Instance Costs (us-east-1)
- **t3.medium**: ~$0.0416/hour
- **Monthly**: ~$30.00
- **Data Transfer**: ~$5-10/month (depending on traffic volume)

### Total Estimated Cost
- **Monthly**: $35-40
- **Daily**: $1.20-1.30

## 🔒 Security Considerations

### Network Security
- Security group restricts access to necessary ports only
- SSH access limited to key-based authentication
- No public access to application ports

### Data Privacy
- No sensitive data stored on EC2 instance
- All traffic is outbound only
- No persistent data collection

### Ethical Guidelines
- Traffic generation follows ethical guidelines
- Respects rate limits and terms of service
- Used for legitimate testing purposes only

## 📞 Support

### Getting Help
1. Check service logs: `sudo journalctl -u trafficflou -n 50`
2. Verify connectivity: `curl -I https://gamedin.xyz`
3. Check system resources: `htop`
4. Review deployment status: `./deploy_aws_trafficflou.sh status`

### Emergency Stop
```bash
# Stop all traffic generation
sudo systemctl stop trafficflou

# Terminate instance
./deploy_aws_trafficflou.sh cleanup
```

---

**🚀 TrafficFlou AWS Deployment - Powered by Lilith Automation**  
**🎯 Multi-Page GameDin.xyz Targeting + Instagram Routing**  
**📈 Exponential Acceleration with Continuous Operation** 