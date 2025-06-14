FROM python:3.10-slim

# Install system dependencies required by Chromium (Playwright)
RUN apt-get update && apt-get install -y \
    wget curl gnupg2 ca-certificates fonts-liberation \
    libnss3 libatk-bridge2.0-0 libatk1.0-0 libcups2 \
    libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxrandr2 libasound2 libx11-xcb1 libxcb1 libxext6 \
    libxfixes3 libglib2.0-0 libgbm1 libpango-1.0-0 \
    libx11-6 libexpat1 libdbus-1-3 libatspi2.0-0 \
    libgtk-3-0 libgdk-pixbuf2.0-0 libasound2-data \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and Chromium
RUN apt-get update && apt-get install -y wget && \
    pip install playwright && playwright install chromium

# Copy the rest of the code
COPY . .

# Expose the port
EXPOSE 8000

# Command to run the app
CMD ["python", "main.py"]
