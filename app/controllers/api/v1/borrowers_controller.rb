module Api::V1
  class BorrowersController < ApplicationController
    before_action :set_borrower, only: [:show, :update, :destroy]

    def index
      @borrowers = Borrower.all
      render json: @borrowers
    end

    def show
      render json: @borrower
    end

    def create
      @borrower = Borrower.new(borrower_params)
      if @borrower.save
        render json: @borrower, status: :created
      else
        render json: @borrower.errors, status: :unprocessable_entity
      end
    end

    def update
      if @borrower.update(borrower_params)
        render json: @borrower
      else
        render json: @borrower.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @borrower.destroy
      head :no_content
    end

    private

    def set_borrower
      @borrower = Borrower.find(params[:id])
    end

    def borrower_params
      params.require(:borrower).permit(:id_card_number, :name, :email)
    end
  end
end