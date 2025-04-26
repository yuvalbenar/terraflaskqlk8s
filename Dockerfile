# this file is a docker file - a set of instructions on how to build a docker image. this docker file creats an image for a flask app.
# this image is then uploaded in a process called CI/CD to an online repository for storeing docker images for the sake of keeping true to gitops princpels.
# said repo will be the source of truth for docker in this program.
# Use a Python 3.8 image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the Flask app code
COPY . /app/

# Expose Flask's default port
EXPOSE 5000

# Set environment variables for Flask
ENV FLASK_APP=app.py

# Run the Flask application
CMD ["flask", "run", "--host", "0.0.0.0"]