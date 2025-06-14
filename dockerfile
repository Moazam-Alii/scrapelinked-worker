# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies needed for Playwright
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    unzip \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxss1 \
    libasound2 \
    libxshmfence1 \
    libgbm-dev \
    libgtk-3-0 \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and browser dependencies
RUN playwright install --with-deps

# Copy the app code
COPY . .

# Expose the port
EXPOSE 8000

# Run the app
CMD ["python", "main.py"]
