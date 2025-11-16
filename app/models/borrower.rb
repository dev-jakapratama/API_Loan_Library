class Borrower < ApplicationRecord
  has_many :loans
  has_many :books, through: :loans

  validates :id_card_number, :name, :email, presence: true
  validates :id_card_number, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def active_loans
    loans.where(status: 'active')
  end

  def has_active_loan?
    active_loans.exists?
  end

  # Add this method for JSON serialization
  def as_json(options = {})
    super(options.merge(methods: [:has_active_loan?]))
  end
end