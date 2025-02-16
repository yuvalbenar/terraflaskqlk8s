FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /

# Copy the application files into the container
COPY . .

# Install the necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port defined in the .env file (the port can be dynamic, so it won't be hardcoded)
EXPOSE ${PORT}

# Run the Flask app when the container starts
CMD ["flask", "run"]

