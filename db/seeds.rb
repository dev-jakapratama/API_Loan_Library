# Clear existing data
Book.destroy_all
Borrower.destroy_all
Loan.destroy_all

puts "Creating sample books..."
books = Book.create!([
  { title: "The Great Gatsby", isbn: "9780743273565", stock: 3 },
  { title: "To Kill a Mockingbird", isbn: "9780061120084", stock: 2 },
  { title: "1984", isbn: "9780452284234", stock: 4 },
  { title: "Pride and Prejudice", isbn: "9780141439518", stock: 3 },
  { title: "The Hobbit", isbn: "9780547928227", stock: 2 },
  { title: "Harry Potter and the Sorcerer's Stone", isbn: "9780590353427", stock: 5 }
])

puts "Creating sample borrowers..."
borrowers = Borrower.create!([
  { id_card_number: "ID001", name: "Alice Johnson", email: "alice@email.com" },
  { id_card_number: "ID002", name: "Bob Smith", email: "bob@email.com" },
  { id_card_number: "ID003", name: "Carol Davis", email: "carol@email.com" },
  { id_card_number: "ID004", name: "David Wilson", email: "david@email.com" },
  { id_card_number: "ID005", name: "Eva Brown", email: "eva@email.com" }
])

puts "Creating sample loans..."
# Create some active loans
Loan.create!(
  book: books[0],
  borrower: borrowers[0],
  borrowed_at: 5.days.ago,
  due_date: 9.days.from_now,
  status: 'active'
)

Loan.create!(
  book: books[1],
  borrower: borrowers[1],
  borrowed_at: 2.days.ago,
  due_date: 12.days.from_now,
  status: 'active'
)

# Create an overdue loan
Loan.create!(
  book: books[2],
  borrower: borrowers[2],
  borrowed_at: 35.days.ago,
  due_date: 5.days.ago,
  status: 'active'
)

# Create some returned loans
Loan.create!(
  book: books[3],
  borrower: borrowers[3],
  borrowed_at: 40.days.ago,
  due_date: 10.days.ago,
  returned_at: 8.days.ago,
  status: 'returned'
)

puts "Seed data created successfully!"
puts "#{Book.count} books created"
puts "#{Borrower.count} borrowers created"
puts "#{Loan.count} loans created"