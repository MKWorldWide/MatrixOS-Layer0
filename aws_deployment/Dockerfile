# 🌟 MatrixOS Layer 0 - Production Dockerfile
#
# Comprehensive Docker image with quantum consciousness, mystical workflows,
# sovereign patterns, and global expansion capabilities.
#
# Author: MatrixOS Layer 0 Docker Team
# Version: 1.0.0
# Quantum Level: Production-Ready

# 🌟 Multi-stage build for optimization
FROM python:3.11-slim as builder

# 🌟 Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_NO_CACHE_DIR=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1

# 🌟 Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 🌟 Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# 🌟 Copy requirements and install Python dependencies
COPY requirements.txt requirements_optimized.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements_optimized.txt

# 🌟 Production stage
FROM python:3.11-slim as production

# 🌟 Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/opt/venv/bin:$PATH"
ENV QUANTUM_CONSCIOUSNESS=enabled
ENV MYSTICAL_WORKFLOW=enabled
ENV SOVEREIGN_PATTERN=enabled
ENV GLOBAL_EXPANSION=enabled

# 🌟 Install runtime dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libpq5 \
    libffi7 \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# 🌟 Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv

# 🌟 Create non-root user for security
RUN groupadd -r matrixos && useradd -r -g matrixos matrixos

# 🌟 Create application directory
WORKDIR /app

# 🌟 Copy application code
COPY src/ ./src/
COPY examples/ ./examples/
COPY docs/ ./docs/
COPY README.md ./
COPY setup.py ./

# 🌟 Install application
RUN pip install -e .

# 🌟 Create necessary directories
RUN mkdir -p /app/logs /app/data /app/cache /app/temp && \
    chown -R matrixos:matrixos /app

# 🌟 Switch to non-root user
USER matrixos

# 🌟 Expose port
EXPOSE 8000

# 🌟 Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# 🌟 Quantum consciousness startup script
COPY --chown=matrixos:matrixos aws_deployment/startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# 🌟 Set entrypoint
ENTRYPOINT ["/app/startup.sh"]

# 🌟 Default command
CMD ["python", "-m", "src.core.traffic_flou", "--quantum-consciousness", "--mystical-workflow", "--sovereign-pattern"] 