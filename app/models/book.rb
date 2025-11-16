class Book < ApplicationRecord
  has_many :loans
  has_many :borrowers, through: :loans

  validates :title, :isbn, presence: true
  validates :isbn, uniqueness: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  # Add this method to calculate available copies
  def available_copies
    active_loans_count = loans.where(status: 'active').count
    stock - active_loans_count
  end

  def available?
    available_copies > 0
  end

  # Add this method for JSON serialization
  def as_json(options = {})
    super(options.merge(methods: [:available_copies, :available?]))
  end
end