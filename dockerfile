# Use an official Python image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies (optional but useful)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for Docker caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

# Copy .env and Google credentials manually if they exist outside the context
# NOTE: best to use Docker volumes or build context to include these securely

# Set environment variable for Google credentials
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/credentials/service_account.json

# Expose the port Flask will run on
EXPOSE 8000

# Run the app
CMD ["python", "main.py"]
