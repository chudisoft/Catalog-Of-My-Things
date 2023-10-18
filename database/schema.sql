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
