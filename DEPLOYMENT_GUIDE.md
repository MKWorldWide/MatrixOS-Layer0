# 🚀 TrafficFlou EC2 Deployment Guide - Lilith Full Automation

## 📋 Overview

This guide provides complete instructions for deploying TrafficFlou on AWS EC2 with full automation, including:
- **Automated instance setup**
- **AWS credentials configuration**
- **Continuous background execution**
- **Self-healing systemd service**
- **Real-time monitoring**
- **Optional S3 log upload**

---

## 🎯 Prerequisites

### Required Files
1. **AWS Credentials CSV**: `PGES_DeveloperUser_accessKeys.csv`
2. **Bootstrap Script**: `bootstrap_trafficflou.sh`
3. **EC2 Instance**: Ubuntu 20.04+ recommended

### AWS Permissions
- EC2 instance access
- S3 access (optional, for log uploads)
- IAM role or access keys

---

## 🚀 Step-by-Step Deployment

### 1. Launch EC2 Instance

```bash
# Launch Ubuntu 20.04+ instance
# Recommended specs: t3.medium or larger
# Security Group: Allow SSH (port 22) and HTTP/HTTPS (ports 80, 443)
```

### 2. Connect to EC2 Instance

```bash
# SSH into your instance
ssh -i your-key.pem ubuntu@your-ec2-ip

# Or use AWS Systems Manager Session Manager
aws ssm start-session --target i-1234567890abcdef0
```

### 3. Upload Required Files

```bash
# Upload AWS credentials CSV
scp -i your-key.pem PGES_DeveloperUser_accessKeys.csv ubuntu@your-ec2-ip:~/

# Upload bootstrap script
scp -i your-key.pem bootstrap_trafficflou.sh ubuntu@your-ec2-ip:~/
```

### 4. Run Bootstrap Script

```bash
# Make script executable
chmod +x bootstrap_trafficflou.sh

# Run the automation script
./bootstrap_trafficflou.sh
```

### 5. Verify Deployment

```bash
# Check service status
sudo systemctl status trafficflou.service

# View live logs
tail -f ~/TrafficFlou/accelerator.log

# Run monitoring dashboard
./monitor_trafficflou.sh
```

---

## 📊 Monitoring & Management

### Real-Time Monitoring

```bash
# View live logs
tail -f ~/TrafficFlou/accelerator.log

# Service status
sudo systemctl status trafficflou.service

# System logs
sudo journalctl -u trafficflou.service -f

# Resource usage
htop
```

### Service Management

```bash
# Restart service
sudo systemctl restart trafficflou.service

# Stop service
sudo systemctl stop trafficflou.service

# Start service
sudo systemctl start trafficflou.service

# Disable auto-start
sudo systemctl disable trafficflou.service
```

### Log Management

```bash
# View recent logs
tail -n 100 ~/TrafficFlou/accelerator.log

# Search logs
grep "ERROR" ~/TrafficFlou/accelerator.log

# Archive logs
cp ~/TrafficFlou/accelerator.log ~/TrafficFlou/accelerator-$(date +%F).log
```

---

## 🔧 Configuration Options

### Customizing the Bootstrap Script

Edit `bootstrap_trafficflou.sh` to modify:

```bash
# Repository URL
REPO_URL="https://github.com/M-K-World-Wide/TrafficFlou.git"

# Python requirements file
REQUIREMENTS="requirements_minimal.txt"

# AWS region
aws configure set default.region us-east-1

# S3 bucket for logs (optional)
S3_BUCKET="your-s3-bucket-name"
```

### Environment Variables

Add to the systemd service for custom configuration:

```bash
Environment=TRAFFICFLOU_TARGET=https://gamedin.xyz
Environment=TRAFFICFLOU_INSTAGRAM_ACCOUNTS=@M.K.Lux,@TheSovereignSunny
Environment=TRAFFICFLOU_EXPONENTIAL_FACTOR=1.5
```

---

## 🛠️ Troubleshooting

### Common Issues

#### 1. Service Won't Start
```bash
# Check service logs
sudo journalctl -u trafficflou.service --no-pager -n 50

# Check file permissions
ls -la ~/TrafficFlou/
ls -la ~/TrafficFlou/venv/bin/python3

# Verify Python environment
~/TrafficFlou/venv/bin/python3 --version
```

#### 2. AWS Credentials Issues
```bash
# Test AWS configuration
aws sts get-caller-identity

# Reconfigure credentials
aws configure

# Check CSV file format
head -n 3 PGES_DeveloperUser_accessKeys.csv
```

#### 3. Dependencies Issues
```bash
# Reinstall dependencies
cd ~/TrafficFlou
source venv/bin/activate
pip install -r requirements_minimal.txt --force-reinstall
```

#### 4. Network Issues
```bash
# Test connectivity
curl -I https://gamedin.xyz
curl -I https://instagram.com

# Check DNS
nslookup gamedin.xyz
nslookup instagram.com
```

### Performance Optimization

#### Resource Limits
```bash
# Increase file descriptor limits
echo "* soft nofile 65536" | sudo tee -a /etc/security/limits.conf
echo "* hard nofile 65536" | sudo tee -a /etc/security/limits.conf

# Restart service
sudo systemctl restart trafficflou.service
```

#### Memory Optimization
```bash
# Monitor memory usage
free -h
ps aux --sort=-%mem | head -10

# Adjust Python memory settings
export PYTHONOPTIMIZE=1
```

---

## 🔄 Updates & Maintenance

### Updating TrafficFlou

```bash
# Pull latest changes
cd ~/TrafficFlou
git pull origin main

# Update dependencies
source venv/bin/activate
pip install -r requirements_minimal.txt --upgrade

# Restart service
sudo systemctl restart trafficflou.service
```

### Backup & Recovery

```bash
# Backup configuration
tar -czf trafficflou-backup-$(date +%F).tar.gz ~/TrafficFlou/

# Backup logs
cp ~/TrafficFlou/accelerator.log ~/backups/

# Restore from backup
tar -xzf trafficflou-backup-2024-01-01.tar.gz
```

---

## 📈 Scaling & High Availability

### Multi-Instance Deployment

1. **Create AMI** from your configured instance
2. **Launch multiple instances** using the AMI
3. **Use Load Balancer** for distribution
4. **Configure Auto Scaling Group**

### Load Balancing

```bash
# Use AWS Application Load Balancer
# Configure health checks
# Set up target groups
# Enable sticky sessions if needed
```

---

## 🔒 Security Considerations

### Network Security
- Use VPC with private subnets
- Configure security groups properly
- Enable CloudTrail logging
- Use IAM roles instead of access keys when possible

### Application Security
- Regular security updates
- Monitor for suspicious activity
- Implement rate limiting
- Use HTTPS for all communications

---

## 📞 Support & Maintenance

### Regular Maintenance Tasks

```bash
# Weekly: Check logs for errors
grep -i error ~/TrafficFlou/accelerator.log

# Monthly: Update dependencies
pip install -r requirements_minimal.txt --upgrade

# Quarterly: Review and rotate logs
find ~/TrafficFlou/ -name "*.log" -mtime +90 -delete
```

### Monitoring Alerts

Set up CloudWatch alarms for:
- CPU utilization > 80%
- Memory usage > 85%
- Disk space < 20%
- Service health checks

---

## 🎉 Success Metrics

### Key Performance Indicators
- **Uptime**: > 99.9%
- **Response Time**: < 2 seconds
- **Error Rate**: < 1%
- **Traffic Generation**: Meeting targets

### Monitoring Dashboard

```bash
# Create custom monitoring script
cat > ~/monitor_detailed.sh << 'EOF'
#!/bin/bash
echo "=== TrafficFlou Detailed Status ==="
echo "Service: $(sudo systemctl is-active trafficflou.service)"
echo "Uptime: $(uptime)"
echo "Memory: $(free -h | grep Mem)"
echo "Disk: $(df -h / | tail -1)"
echo "Recent Logs:"
tail -n 10 ~/TrafficFlou/accelerator.log
EOF

chmod +x ~/monitor_detailed.sh
```

---

## 📚 Additional Resources

- [TrafficFlou Documentation](./README.md)
- [Architecture Guide](./docs/architecture.md)
- [API Reference](./docs/api.md)
- [Troubleshooting Guide](./docs/troubleshooting.md)

---

**🚀 Your TrafficFlou system is now fully automated and ready for production use!** 