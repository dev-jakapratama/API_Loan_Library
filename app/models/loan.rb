class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :borrower

  validates :borrowed_at, :due_date, presence: true
  validate :due_date_within_limit
  validate :no_concurrent_loans, on: :create
  validate :book_available, on: :create

  before_validation :set_borrowed_at, on: :create
  before_validation :set_status, on: :create

  scope :active, -> { where(status: 'active') }
  scope :overdue, -> { active.where('due_date < ?', Time.current) }

  def overdue?
    active? && due_date < Time.current
  end

  def active?
    status == 'active'
  end

  def returned?
    returned_at.present?
  end

  def return_book
    update(returned_at: Time.current, status: 'returned')
  end

  def days_overdue
    return 0 unless overdue?
    (Time.current.to_date - due_date.to_date).to_i
  end

  # Add this method for JSON serialization
  def as_json(options = {})
    super(options.merge(methods: [:overdue?, :active?, :returned?, :days_overdue]))
  end

  private

  def set_borrowed_at
    self.borrowed_at ||= Time.current
  end

  def set_status
    self.status ||= 'active'
  end

  def due_date_within_limit
    return unless due_date && borrowed_at
    if due_date > borrowed_at + 30.days
      errors.add(:due_date, 'cannot be more than 30 days from borrow date')
    end
  end

  def no_concurrent_loans
    if borrower&.has_active_loan?
      errors.add(:base, 'Borrower already has an active loan')
    end
  end

  def book_available
    if book && !book.available?
      errors.add(:base, 'Book is not available for borrowing')
    end
  end
end