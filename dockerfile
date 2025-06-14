# Use official Playwright base image with Python 3.10
FROM mcr.microsoft.com/playwright/python:v1.43.1

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your code into the container
COPY . .

# Expose the app port
EXPOSE 8000

# Start the app
CMD ["python", "main.py"]
