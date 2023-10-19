-- Create a table for items
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  archived BOOLEAN,
  item_type VARCHAR(255)
);

-- Create a table for books
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  publisher VARCHAR(255),
  cover_state VARCHAR(255),
  item_id INTEGER,
  FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Create a table for labels
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  color VARCHAR(255)
);

-- Create a many-to-many relationship table between items and labels
CREATE TABLE item_labels (
  item_id INTEGER,
  label_id INTEGER,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (label_id) REFERENCES labels(id)
);

-- Table for music_albums
CREATE TABLE music_albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    on_spotify BOOLEAN,
    item_id INTEGER,
    music_album_id INT,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Table for genres
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table for items_genres (many-to-many relationship)
CREATE TABLE items_genres (
    item_id INT,
    genre_id INT,
    PRIMARY KEY (item_id, genre_id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);