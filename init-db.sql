-- Create the database if it doesn't exist and switch to it
CREATE DATABASE IF NOT EXISTS flaskdb;
USE flaskdb;

-- Create the visitor_counter table
CREATE TABLE IF NOT EXISTS visitor_counter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    count INT NOT NULL DEFAULT 0
);

-- Initialize the counter with a starting value of 0
INSERT INTO visitor_counter (count) VALUES (0);

-- Create the images table
CREATE TABLE IF NOT EXISTS images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(255) UNIQUE NOT NULL
);

-- Insert GIF URLs (duplicates will be ignored)
INSERT IGNORE INTO images (url) 
VALUES 
    ('https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExOXpyZDlzODRsejNicHc4dDVvNXRscjdybDNldXc1eWhqejM3cjY4ciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/QvBoMEcQ7DQXK/giphy.gif'),
    ('https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3EzNWVlOWFjaGtpYjdxaWc3c2RxOHZrNG44dHI4NXNmdHk0MDJ5aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yXBqba0Zx8S4/giphy-downsized.gif'),
    ('https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExcW5uZGR6MjZtdXAycmFhbHFqbHlzdmN2eTF0dnZtN2prZ3RpdjllcyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l41Yzkvl2h3roxkuk/giphy.gif');
