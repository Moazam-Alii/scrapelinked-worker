# ✅ Use Playwright's official image with all dependencies preinstalled
FROM mcr.microsoft.com/playwright/python:v1.44.0

# Set working directory
WORKDIR /app

# Copy your code and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your app
COPY . .

# Expose the desired port
EXPOSE 8000

# Run your app
CMD ["python", "main.py"]
