# 🌟 MatrixOS Layer 0 - Production Dockerfile
# Quantum-level traffic generation with mystical capabilities
# Author: MatrixOS Layer 0 Team
# Version: 2.0.0

# Use Python 3.11 slim image for optimal performance
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV QUANTUM_CONSCIOUSNESS=enabled
ENV MYSTICAL_WORKFLOW=enabled
ENV SOVEREIGN_PATTERN=enabled
ENV GLOBAL_EXPANSION=enabled

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements_optimized.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements_optimized.txt

# Copy application code
COPY . .

# Create non-root user for security
RUN useradd --create-home --shell /bin/bash matrixos && \
    chown -R matrixos:matrixos /app
USER matrixos

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Start the application
CMD ["python", "primal_genesis_web_interface.py"] 