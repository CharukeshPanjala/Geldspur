module Api
    module V1
        class BudgetsController < ApplicationController
            before_action :set_budget, only: [ :show, :update, :destroy ]

            # GET /budgets
            def index
                @budgets = Budget.all
                render json: BudgetSerializer.new(@budgets).serializable_hash.to_json
            end

            # GET /budgets/:id
            def show
                render json: BudgetSerializer.new(@budget).serializable_hash.to_json
            end

            # POST /budgets
            def create
                @budget = Budget.new(budget_params)
                if @budget.save
                    render json: BudgetSerializer.new(@budget).serializable_hash.to_json, status: :created
                else
                    render json: { errors: @budget.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PUT /budgets/:id
            def update
                if @budget.update(budget_params)
                    render json: BudgetSerializer.new(@budget).serializable_hash.to_json
                else
                    render json: { errors: @budget.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /budgets/:id
            def destroy
                @budget.destroy
                head :no_content
            end

            private

            def set_budget
                @budget = Budget.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Budget not found" }, status: :not_found
            end

            def budget_params
                params.require(:budget).permit(:amount, :start_date, :end_date, :category_id, :user_id)
            end
        end
    end
end
