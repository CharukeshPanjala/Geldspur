module Api
    module V1
        class ExpensesController < ApplicationController
            before_action :set_expense, only: [ :show, :update, :destroy ]
            # GET /expenses
            def index
                @expenses = Expense.all
                render json: ExpenseSerializer.new(@expenses).serializable_hash.to_json
            end                                 


            # GET /expenses/:id
            def show
                render json: ExpenseSerializer.new(@expense).serializable_hash.to_json
            end             


            # POST /expenses
            def create  
                @expense = Expense.new(expense_params)
                if @expense.save
                    render json: ExpenseSerializer.new(@expense).serializable_hash.to_json, status: :created
                else
                    render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
                end 
            end

            # PUT /expenses/:id
            def update
                if @expense.update(expense_params)
                    render json: ExpenseSerializer.new(@expense).serializable_hash.to_json
                else
                    render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
                end
            end


            # DELETE /expenses/:id
            def destroy
                @expense.destroy
                head :no_content
            end

            private
            def set_expense
                @expense = Expense.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Expense not found" }, status: :not_found
            end

            def expense_params          
                params.require(:expense).permit(:title, :description, :amount, :expense_date, :payment_method, :category_id, :user_id)
            end
        end
    end
end
