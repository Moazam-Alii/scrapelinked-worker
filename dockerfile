FROM python:3.10-slim

# Install necessary system libraries for Chromium/Playwright
RUN apt-get update && apt-get install -y \
    wget curl gnupg2 ca-certificates fonts-liberation \
    libnss3 libatk-bridge2.0-0 libatk1.0-0 libcups2 \
    libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxrandr2 libasound2 libx11-xcb1 libxcb1 libxext6 \
    libxfixes3 libglib2.0-0 libgbm1 libpango-1.0-0 \
    libx11-6 libexpat1 libdbus-1-3 libatspi2.0-0 \
    libgtk-3-0 libgdk-pixbuf2.0-0 libasound2-data \
    libnspr4 libnss3 libnssutil3 libsmime3 libxcomposite1 \
    libxdamage1 libxrandr2 libgbm1 libxext6 libxfixes3 \
    libatk1.0-0 libatk-bridge2.0-0 libatspi2.0-0 \
    libcairo2 libpango-1.0-0 libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 libgtk-3-0 libx11-6 libx11-xcb1 \
    libxcb1 libxcomposite1 libxdamage1 libxext6 \
    libxfixes3 libxrandr2 libxkbcommon0 libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and Chromium
RUN pip install playwright && playwright install chromium

# Copy source code
COPY . .

# Expose your app port
EXPOSE 8000

# Command to run the app
CMD ["python", "main.py"]
