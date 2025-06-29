#!/usr/bin/env python3
"""
🔍 TrafficFlou Status Checker
Monitor both local and AWS deployments
"""

import subprocess
import os
import time
from datetime import datetime

def check_local_status():
    """Check local TrafficFlou status"""
    print("🖥️  LOCAL DEPLOYMENT STATUS")
    print("=" * 50)
    
    # Check if Python process is running
    try:
        result = subprocess.run(['pgrep', '-f', 'start_gamedin_traffic.py'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ Local TrafficFlou: RUNNING")
            print(f"   Process IDs: {result.stdout.strip()}")
        else:
            print("❌ Local TrafficFlou: NOT RUNNING")
    except Exception as e:
        print(f"⚠️  Could not check local status: {e}")
    
    # Check log file
    if os.path.exists('trafficflou.log'):
        print("✅ Log file: EXISTS")
        # Get last few lines
        try:
            result = subprocess.run(['tail', '-5', 'trafficflou.log'], 
                                  capture_output=True, text=True)
            print("📝 Recent logs:")
            for line in result.stdout.strip().split('\n'):
                if line.strip():
                    print(f"   {line}")
        except Exception as e:
            print(f"⚠️  Could not read logs: {e}")
    else:
        print("❌ Log file: NOT FOUND")

def check_aws_status():
    """Check AWS deployment status"""
    print("\n☁️  AWS DEPLOYMENT STATUS")
    print("=" * 50)
    
    # Check if deployment script exists
    if os.path.exists('deploy_aws_trafficflou.sh'):
        print("✅ Deployment script: EXISTS")
        
        # Check if instance files exist
        if os.path.exists('.instance_id') and os.path.exists('.public_ip'):
            print("✅ Instance files: EXIST")
            
            # Read instance info
            try:
                with open('.instance_id', 'r') as f:
                    instance_id = f.read().strip()
                with open('.public_ip', 'r') as f:
                    public_ip = f.read().strip()
                
                print(f"   Instance ID: {instance_id}")
                print(f"   Public IP: {public_ip}")
                
                # Check instance status via AWS CLI
                try:
                    result = subprocess.run([
                        'aws', 'ec2', 'describe-instances',
                        '--instance-ids', instance_id,
                        '--query', 'Reservations[0].Instances[0].State.Name',
                        '--output', 'text'
                    ], capture_output=True, text=True)
                    
                    if result.returncode == 0:
                        state = result.stdout.strip()
                        print(f"   Instance State: {state}")
                        
                        if state == 'running':
                            print("✅ AWS Instance: RUNNING")
                            
                            # Try to check service status
                            try:
                                ssh_cmd = f"ssh -i trafficflou-key.pem -o ConnectTimeout=5 -o StrictHostKeyChecking=no ec2-user@{public_ip} 'sudo systemctl is-active trafficflou'"
                                result = subprocess.run(ssh_cmd, shell=True, capture_output=True, text=True)
                                
                                if result.returncode == 0:
                                    service_status = result.stdout.strip()
                                    if service_status == 'active':
                                        print("✅ TrafficFlou Service: ACTIVE")
                                    else:
                                        print(f"⚠️  TrafficFlou Service: {service_status}")
                                else:
                                    print("⚠️  Could not check service status")
                            except Exception as e:
                                print(f"⚠️  Service check failed: {e}")
                        else:
                            print(f"❌ AWS Instance: {state}")
                    else:
                        print("⚠️  Could not check instance status")
                        
                except Exception as e:
                    print(f"⚠️  AWS CLI check failed: {e}")
                    
            except Exception as e:
                print(f"⚠️  Could not read instance files: {e}")
        else:
            print("❌ Instance files: NOT FOUND")
    else:
        print("❌ Deployment script: NOT FOUND")

def check_network_connectivity():
    """Check network connectivity to targets"""
    print("\n🌐 NETWORK CONNECTIVITY")
    print("=" * 50)
    
    targets = [
        ("GameDin.xyz", "https://gamedin.xyz"),
        ("Instagram", "https://www.instagram.com")
    ]
    
    for name, url in targets:
        try:
            result = subprocess.run(['curl', '-I', '--connect-timeout', '5', url], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                print(f"✅ {name}: ACCESSIBLE")
            else:
                print(f"❌ {name}: NOT ACCESSIBLE")
        except Exception as e:
            print(f"⚠️  {name}: CHECK FAILED ({e})")

def check_system_resources():
    """Check system resource usage"""
    print("\n💻 SYSTEM RESOURCES")
    print("=" * 50)
    
    # Check CPU and memory
    try:
        result = subprocess.run(['top', '-l', '1', '-n', '0'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            lines = result.stdout.split('\n')
            for line in lines:
                if 'CPU usage' in line:
                    print(f"   {line.strip()}")
                elif 'PhysMem' in line:
                    print(f"   {line.strip()}")
    except Exception as e:
        print(f"⚠️  Could not check system resources: {e}")

def main():
    """Main status check function"""
    print("🚀 TRAFFICFLOU STATUS CHECK")
    print("=" * 60)
    print(f"📅 Check Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    check_local_status()
    check_aws_status()
    check_network_connectivity()
    check_system_resources()
    
    print("\n" + "=" * 60)
    print("🔍 Status check completed!")
    print("\n💡 Quick Commands:")
    print("   Local start: python3 start_gamedin_traffic.py")
    print("   AWS status: ./deploy_aws_trafficflou.sh status")
    print("   AWS SSH: ssh -i trafficflou-key.pem ec2-user@<IP>")
    print("   Cleanup: ./deploy_aws_trafficflou.sh cleanup")

if __name__ == "__main__":
    main() 