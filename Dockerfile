# Set the Python version as a build-time argument
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create a virtual environment
RUN python -m venv /opt/venv

# Add the virtual environment to the PATH
ENV PATH=/opt/venv/bin:$PATH

# Upgrade pip
RUN pip install --upgrade pip

# Create the application directory in the container
RUN mkdir -p /code
WORKDIR /code

# Copy the requirements file from the root directory
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies
RUN pip install -r /tmp/requirements.txt

# Copy the project source code from the src directory
COPY src/ /code

# Set the Django default project name
ARG PROJ_NAME="cfehome"

# Create a bash script to run the Django project
RUN printf "#!/bin/bash\n" > paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"0.0.0.0:\$RUN_PORT\"\n" >> paracord_runner.sh

# Make the bash script executable
RUN chmod +x paracord_runner.sh

# Default command to run the application
CMD ["./paracord_runner.sh"]
