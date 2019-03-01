CREATE TABLE bookshelves (id SERIAL PRIMARY KEY, name VARCHAR(255));
-- Creates original bookshelves table

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;
-- Populates bookshelves with data from books

SELECT COUNT(*) FROM bookshelves;
-- Confirms it worked

ALTER TABLE books ADD COLUMN bookshelf_id INT;
-- creates a new table column to reflect unique bookshelf names with an id

UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;
-- populates that id with the proper data from the books table, wherever the bookshelves match

ALTER TABLE books DROP COLUMN bookshelf;
-- removes the bookshelf names now that we have an id to use instead

ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
-- connects the bookshelf_id from books, and id from bookshelves, so that they always match properly