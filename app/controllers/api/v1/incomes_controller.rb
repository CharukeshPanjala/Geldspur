module Api
  module V1
    class IncomesController < ApplicationController
      before_action :authenticate_user!              # Devise authentication
      before_action :set_income, only: [ :show, :update, :destroy ]

      # GET /incomes
      def index
        @incomes = current_user.incomes
        render json: @incomes.map(&:as_json_response)
      end

      # GET /incomes/:id
      def show
        render json: @income.as_json_response
      end

      # POST /incomes
      def create
        @income = Income.new(income_params)
        if @income.save
          render json: @income.as_json_response, status: :created
        else
          render json: { errors: @income.errors.full_messages }, status: :unprocessable_content
        end
      end

      # PUT /incomes/:id
      def update
        if @income.update(income_params)
          render json: @income.as_json_response
        else
          render json: { errors: @income.errors.full_messages }, status: :unprocessable_content
        end
      end

      # DELETE /incomes/:id
      def destroy
        @income.destroy
        head :no_content
      end

      private

      def set_income
        @income = current_user.incomes.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Income not found" }, status: :not_found
      end

      def income_params
        params.require(:income).permit(:title, :description, :amount, :income_date, :payment_method, :user_id, :category_id)
      end
    end
  end
end
