module Api
    module V1
        class CategoriesController < ApplicationController
            before_action :set_category, only: [ :show, :update, :destroy]

            # GET /categories
            def index
                @categories = Category.all
                render json: CategorySerializer.new(@categories).serializable_hash.to_json
            end

            # GET /categories/:id
            def show
                render json: CategorySerializer.new(@category).serializable_hash.to_json
            end

            # POST /categories
            def create
                @category = Category.new(category_params)
                if @category.save
                    render json: CategorySerializer.new(@category).serializable_hash.to_json, status: :created
                else
                    render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PUT /categories/:id
            def update
                if @category.update(category_params)
                    render json: CategorySerializer.new(@category).serializable_hash.to_json
                else
                    render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /categories/:id
            def destroy
                @category.destroy
                head :no_content
            end

            private

            def set_category
                @category = Category.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Category not found" }, status: :not_found
            end

            def category_params
                params.require(:category).permit(:name, :description, :category_type, :slug, :user_id)
            end
        end
    end
end
