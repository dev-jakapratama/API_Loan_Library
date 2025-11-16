class CreateBooksBorrowersLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :isbn, null: false
      t.integer :stock, null: false, default: 0

      t.timestamps null: false
    end

    add_index :books, :isbn, unique: true

    create_table :borrowers do |t|
      t.string :id_card_number, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps null: false
    end

    add_index :borrowers, :id_card_number, unique: true

    create_table :loans do |t|
      t.references :book, null: false, foreign_key: true
      t.references :borrower, null: false, foreign_key: true
      t.datetime :borrowed_at, null: false
      t.datetime :due_date, null: false
      t.datetime :returned_at
      t.string :status, null: false, default: 'active'

      t.timestamps null: false
    end
  end
end
