import os
import mysql.connector
import random
import time
from flask import Flask, render_template, Response
from dotenv import load_dotenv
from mysql.connector import Error
from prometheus_client import Gauge, generate_latest, CONTENT_TYPE_LATEST
from prometheus_flask_exporter import PrometheusMetrics

# Load environment variables from .env file or GitHub secrets
load_dotenv()

app = Flask(__name__)

# Define a Prometheus Gauge for tracking visitor count
visitor_count_gauge = Gauge('flask_app_visitor_count', 'Current number of visitors')

def get_db_connection():
    retries = 5
    while retries > 0:
        try:
            # Connecting to MySQL database with credentials from the .env file
            connection = mysql.connector.connect(
                host=os.getenv('DATABASE_HOST', 'gif-db'),
                port=int(os.getenv('DATABASE_PORT', 3306)),
                user=os.getenv('DATABASE_USER', 'root'),
                password=os.getenv('DATABASE_PASSWORD', 'password'),
                database=os.getenv('DATABASE_NAME', 'flaskdb')
            )
            if connection.is_connected():
                return connection
        except Error as e:
            print(f"Error connecting to MySQL: {e}")
            retries -= 1
            time.sleep(2)
    raise Exception("Failed to connect to the database after multiple attempts")

@app.route('/')
def index():
    # Connect to the database and fetch a random image URL
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT url FROM images ORDER BY RAND() LIMIT 1")
    random_image = cursor.fetchone()[0]
    cursor.close()
    connection.close()
    return render_template('index.html', image=random_image)

@app.route('/metrics')
def metrics():
    # Connect to the database to get the visitor count
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT count FROM visitor_counter WHERE id = 1")
    result = cursor.fetchone()
    if result:
        visitor_count = result[0]
        visitor_count_gauge.set(visitor_count)
    cursor.close()
    connection.close()

    # Return the Prometheus metrics data
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
