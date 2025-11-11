module Api
    module V1
        class UsersController < ApplicationController
            before_action :set_user, only: [ :show, :update, :destroy ]

            # GET /users
            def index
                @users = User.all
                render json: @users.map(&:as_json_response)
            end

            # GET /users/:id
            def show
                render json: @user.as_json_response
            end

            # POST /users
            def create
                @user = User.new(user_params)
                if @user.save
                    render json: @user.as_json_response, status: :created
                else
                    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PUT /users/:id
            def update
                if @user.update(user_params)
                    render json: @user.as_json_response
                else
                    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /users/:id
            def destroy
                @user.destroy
                head :no_content
            end

            private

            def set_user
                @user = User.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: "User not found" }, status: :not_found
            end

            def user_params
                params.require(:user).permit(:first_name, :last_name, :email, :password, :mobile_number, :country, :city)
            end
        end
    end
end
