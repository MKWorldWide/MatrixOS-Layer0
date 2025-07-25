# TrafficFlou Amplify GitHub Setup Guide

## 🔗 **Connecting GitHub Repository to AWS Amplify**

### **Step 1: Create GitHub Personal Access Token**

1. **Go to GitHub Settings:**
   - Visit: https://github.com/settings/tokens
   - Click "Generate new token (classic)"

2. **Configure Token Permissions:**
   - **Note:** `TrafficFlou-Amplify-Access`
   - **Expiration:** 90 days (recommended)
   - **Scopes:**
     - ✅ `repo` (Full control of private repositories)
     - ✅ `admin:repo_hook` (Full control of repository hooks)

3. **Generate Token:**
   - Click "Generate token"
   - **IMPORTANT:** Copy the token immediately (you won't see it again!)

### **Step 2: Connect Repository in AWS Amplify Console**

1. **Open AWS Amplify Console:**
   - Go to: https://console.aws.amazon.com/amplify/
   - Select the **TrafficFlou** app (`dwtq2xpv6r5lo`)

2. **Connect Repository:**
   - Click "Connect repository"
   - Select "GitHub" as the repository service
   - Click "Continue"

3. **Authorize GitHub:**
   - Click "Authorize AWS Amplify"
   - Grant access to your GitHub account
   - Select the `M-K-World-Wide/TrafficFlou` repository

4. **Configure Branch:**
   - **Branch:** `main`
   - **Environment:** `Production`
   - Click "Next"

### **Step 3: Configure Build Settings**

1. **Build Settings:**
   - **Build image:** `Ubuntu 20.04 LTS`
   - **Service role:** Use existing service role
   - Click "Next"

2. **Review and Deploy:**
   - Review the configuration
   - Click "Save and deploy"

### **Step 4: Configure Environment Variables**

After the initial deployment, add these environment variables:

1. **Go to App Settings > Environment Variables**
2. **Add the following variables:**

```bash
# AI Provider API Keys
OPENAI_API_KEY=your_openai_key_here
ANTHROPIC_API_KEY=your_anthropic_key_here
MISTRAL_API_KEY=your_mistral_key_here
GOOGLE_API_KEY=your_google_key_here
COHERE_API_KEY=your_cohere_key_here
DEEPSEEK_API_KEY=your_deepseek_key_here

# TrafficFlou Configuration
TRAFFICFLOU_LOG_LEVEL=INFO
TRAFFICFLOU_ENVIRONMENT=production
QUANTUM_ENTROPY_LEVEL=42
ETHEREAL_FREQUENCY=144.000

# Web Interface Configuration
HOST=0.0.0.0
PORT=8080
DEBUG=false
LOG_LEVEL=info
```

### **Step 5: Verify Deployment**

1. **Check Build Status:**
   - Monitor the build process in the Amplify console
   - Ensure all dependencies are installed correctly

2. **Test the Application:**
   - Visit the provided Amplify URL
   - Test the Primal Genesis Web Interface
   - Verify all API endpoints are working

3. **Check Logs:**
   - Go to "Hosting environments" > "main"
   - Check build logs for any errors
   - Monitor application logs

## 🛠️ **Troubleshooting**

### **Common Issues:**

1. **Build Fails:**
   - Check `requirements.txt` for missing dependencies
   - Verify Python version compatibility
   - Check build logs for specific errors

2. **Import Errors:**
   - Ensure `PYTHONPATH` is set correctly
   - Check that all modules are in the correct locations
   - Verify import statements in `primal_genesis_web_interface.py`

3. **Port Issues:**
   - Ensure `PORT` environment variable is set to `8080`
   - Check that the application binds to `0.0.0.0`

4. **API Key Issues:**
   - Verify all API keys are set correctly
   - Check that the keys have proper permissions
   - Test API connectivity

### **Useful Commands:**

```bash
# Check build logs
aws amplify get-job --app-id dwtq2xpv6r5lo --branch-name main --job-id <job-id>

# List environment variables
aws amplify list-env-vars --app-id dwtq2xpv6r5lo

# Update environment variables
aws amplify update-env-var --app-id dwtq2xpv6r5lo --name VARIABLE_NAME --value VARIABLE_VALUE
```

## 🚀 **Deployment Checklist**

- [ ] GitHub Personal Access Token created
- [ ] Repository connected to Amplify
- [ ] Build configuration verified
- [ ] Environment variables set
- [ ] Initial deployment successful
- [ ] Web interface accessible
- [ ] API endpoints working
- [ ] Logs monitored and clean

## 📞 **Support**

If you encounter issues:
1. Check the Amplify build logs
2. Verify GitHub repository permissions
3. Ensure all environment variables are set
4. Test the application locally first

---

**Once completed, your TrafficFlou Primal Genesis Web Interface will be live on AWS Amplify!** 🌟 