module Api
    module V1
        class IncomesController < ApplicationController
            before_action :set_income, only: [ :show, :update, :destroy]

            # GET /incomes
            def index
                @incomes = Income.all
                render json: IncomeSerializer.new(@incomes).serializable_hash.to_json
            end

            # GET /incomes/:id
            def show
                render json: IncomeSerializer.new(@income).serializable_hash.to_json
            end

            # POST /incomes
            def create
                @income = Income.new(income_params)
                if @income.save
                    render json: IncomeSerializer.new(@income).serializable_hash.to_json, status: :created
                else
                    render json: { errors: @income.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PUT /incomes/:id
            def update
                if @income.update(income_params)
                    render json: IncomeSerializer.new(@income).serializable_hash.to_json
                else
                    render json: { errors: @income.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /incomes/:id
            def destroy
                @income.destroy
                head :no_content
            end

            private

            def set_income
                @income = Income.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Income not found" }, status: :not_found
            end

            def income_params
                params.require(:income).permit(:amount, :source, :received_on, :user_id, :category_id)
            end
        end
    end
end
