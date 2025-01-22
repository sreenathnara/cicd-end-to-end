# Use an official Python runtime as a parent image
FROM python:3.9-slim  # Specify a version to avoid ambiguity, use a slim image for smaller size

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install necessary system dependencies (like distutils, which may be required by Django)
RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-distutils \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version and install the Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt  # Ensure you have a requirements.txt that lists your Django version and any other dependencies

# Apply database migrations
RUN python manage.py migrate

# Expose the port the app runs on
EXPOSE 8000

# Define the command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
