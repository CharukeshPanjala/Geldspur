module Api
    module V1
        class BudgetsController < ApplicationController
            before_action :authenticate_user!              # Devise authentication
            before_action :set_budget, only: [ :show, :update, :destroy ]

            # GET /budgets
            def index
                @budgets = current_user.budgets
                render json: @budgets.map(&:as_json_response)
            end

            # GET /budgets/:id
            def show
                render json: @budget.as_json_response
            end

            # POST /budgets
            def create
                @budget = Budget.new(budget_params)
                if @budget.save
                    render json: @budget.as_json_response, status: :created
                else
                    render json: { errors: @budget.errors.full_messages }, status: :unprocessable_content
                end
            end

            # PUT /budgets/:id
            def update
                if @budget.update(budget_params)
                    render json: @budget.as_json_response
                else
                    render json: { errors: @budget.errors.full_messages }, status: :unprocessable_content
                end
            end

            # DELETE /budgets/:id
            def destroy
                @budget.destroy
                head :no_content
            end

            private

            def set_budget
                @budget =current_user.budgets.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Budget not found" }, status: :not_found
            end

            def budget_params
                params.require(:budget).permit(:name, :description, :amount, :start_date, :end_date, :category_id, :user_id)
            end
        end
    end
end
