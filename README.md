# README


* Ruby version : 3.4.1

* SQL : library_loan.sql


Setup and RUn :

install rbenv / rvm 3.4.1
Rails : 8.1.1

- bundle install
- rails db:migrate
- rails s

## API Endpoints

### Books
- GET /api/v1/books - List all books
- POST /api/v1/books - Create new book
- GET/PUT/DELETE /api/v1/books/:id - Book operations

### Borrowers
- GET /api/v1/borrowers - List all borrowers
- POST /api/v1/borrowers - Create new borrower
- GET/PUT/DELETE /api/v1/borrowers/:id - Borrower operations

### Loans
- GET /api/v1/loans - List all loans
- POST /api/v1/loans - Create new loan
- POST /api/v1/loans/:id/return_book - Return a book
- GET /api/v1/loans/active_loans - Active loans only
- GET /api/v1/loans/overdue_loans - Overdue loans only


## Business Rules Implemented

1. ✅ Book stock validation
2. ✅ No concurrent loans per borrower
3. ✅ Maximum 30-day loan duration
4. ✅ One book per loan
5. ✅ Automatic overdue detection
6. ✅ Real-time availability calculation


Access UI at http://localhost:5173


### there's seed data : db/seeds.rb --> rails db:seed

Manually Run Sqlite 
__________________________
# Membuat database baru
sqlite3 library_loan.db

# Di SQLite shell, jalankan file SQL
sqlite> .read library_loan.sql

# Atau langsung dari command line
sqlite3 library_loan.db < library_loan.sql


Simple Install below
cd library_loan_api
rails db:drop db:create db:migrate db:seed
rails server