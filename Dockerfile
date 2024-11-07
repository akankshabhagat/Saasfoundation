# Set the Python version as a build-time argument with 3.12 as the default
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Create a virtual environment
RUN python -m venv /venv

# Update the PATH to use the virtual environment's Python and pip
ENV PATH="/venv/bin:$PATH"

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy requirements file to the container
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install -r /tmp/requirements.txt

# Set the working directory (optional, depending on where your code will be placed)
WORKDIR /app

# Copy application code into the container (update the source path as necessary)
COPY ./src /app

# Run the container with an interactive shell by default (or specify a different command)
CMD ["python", "--version"]