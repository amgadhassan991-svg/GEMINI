# Use Python 3.11 slim base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Environment settings
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies needed to build some Python packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip \
    && pip install -r /app/requirements.txt

# Copy application code
COPY . /app

# Expose port
EXPOSE 8000

# Default command (assumes your FastAPI app is in main.py and the ASGI app instance is named "app")
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
