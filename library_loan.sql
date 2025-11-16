-- Create books table
CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  isbn TEXT NOT NULL UNIQUE,
  stock INTEGER NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- Create borrowers table
CREATE TABLE borrowers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  id_card_number TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- Create loans table
CREATE TABLE loans (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id INTEGER NOT NULL,
  borrower_id INTEGER NOT NULL,
  borrowed_at DATETIME NOT NULL,
  due_date DATETIME NOT NULL,
  returned_at DATETIME,
  status TEXT NOT NULL DEFAULT 'active',
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (book_id) REFERENCES books (id),
  FOREIGN KEY (borrower_id) REFERENCES borrowers (id)
);

-- Create indexes for better performance
CREATE INDEX index_books_on_isbn ON books (isbn);
CREATE INDEX index_borrowers_on_id_card_number ON borrowers (id_card_number);
CREATE INDEX index_loans_on_book_id ON loans (book_id);
CREATE INDEX index_loans_on_borrower_id ON loans (borrower_id);
CREATE INDEX index_loans_on_status ON loans (status);
CREATE INDEX index_loans_on_due_date ON loans (due_date);