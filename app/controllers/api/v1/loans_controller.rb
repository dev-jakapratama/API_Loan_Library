module Api::V1
  class LoansController < ApplicationController
    before_action :set_loan, only: [:show, :return_book]

    def index
      @loans = Loan.includes(:book, :borrower).all
      render json: @loans, include: ['book', 'borrower']
    end

    def show
      render json: @loan, include: ['book', 'borrower']
    end

    def create
      @loan = Loan.new(loan_params)
      if @loan.save
        render json: @loan, include: ['book', 'borrower'], status: :created
      else
        render json: @loan.errors, status: :unprocessable_entity
      end
    end

    def return_book
      if @loan.return_book
        render json: @loan, include: ['book', 'borrower']
      else
        render json: @loan.errors, status: :unprocessable_entity
      end
    end

    def active_loans
      @loans = Loan.active.includes(:book, :borrower)
      render json: @loans, include: ['book', 'borrower']
    end

    def overdue_loans
      @loans = Loan.overdue.includes(:book, :borrower)
      render json: @loans, include: ['book', 'borrower']
    end

    private

    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:book_id, :borrower_id, :due_date)
    end
  end
end