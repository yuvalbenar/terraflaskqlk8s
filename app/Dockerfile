# Use a minimal Python 3.8 image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary files first
COPY app.py /app/

# Ensure correct copying of templates and static files
COPY templates /app/templates 

# Copy everything else
COPY . /app/

# Expose Flask's default port
EXPOSE 5000

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_ENV=development
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Run the Flask application
CMD ["flask", "run"]
