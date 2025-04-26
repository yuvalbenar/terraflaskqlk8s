# this file is a flask app file. flask is a webframework for building web apps in the python languge.
# this specific flask app is built for the purpuse of a website which will present a theme (described via html)
# then showcase content imported from a database. in our case - random gifs of the mighty beagle. 
# the app will first import the libraris requierd to run the app with all its current feauters in mind.

import os # calls for pythons built in os module which creats a way to comnunicate with the systems os for file paths etc
import mysql.connector # a library for comunication with a mysql database.
import random # Imports Python's built-in module for generating pseudo-random numbers and performing random selections.
import time # Imports the time module, providing functions to work with time (e.g., delays, timestamps).
from flask import Flask, render_template, Response  # due to python's explicit import philosophy nothing is imported by default. not even python native apps. the imported flask components are as follows: flask- The main class for creating a web application. render_template- Renders HTML templates, response- Constructs HTTP response objects. 
from dotenv import load_dotenv # Imports the function to load environment variables from a .env file
from mysql.connector import Error #Imports the Error class from the MySQL Connector, used for handling database connection and query errors.
from prometheus_client import Gauge, generate_latest, CONTENT_TYPE_LATEST # Imports components for monitoring - gauge being a metric type for values that go up and down,content type defiens the http data type to be scraped to assure the http data is readable for the monitoring componnents.

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
    # Increment the visitor counter
    cursor.execute("UPDATE visitor_counter SET count = count + 1 WHERE id = 1")
    connection.commit()
    print("Rows affected:", cursor.rowcount)
    #fetch a random image url
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

@app.route('/healthz')
def health_check():
    return "OK", 200  # Simple health check endpoint

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
