module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user, only: [ :show, :update, :destroy ]
      before_action :authorize_admin!, only: [ :index, :destroy ]

      # GET /users
      def index
        # Only admins can access this
        @users = User.all
        render json: @users.map(&:as_json_response)
      end

      # GET /users/:id
      def show
        if current_user != @user && !current_user.admin?
          render json: { error: "Access denied" }, status: :forbidden
        else
          render json: @user.as_json_response
        end
      end

      # PUT /users/:id
      def update
        if current_user != @user && !current_user.admin?
          render json: { error: "Access denied" }, status: :forbidden
        else
          if @user.update(user_params)
            render json: @user.as_json_response
          else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
          end
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
        params.require(:user).permit(
          :first_name, :last_name, :email, :password,
          :mobile_number, :country, :city, :admin
        )
      end

      def authorize_admin!
        render json: { error: "Access denied" }, status: :forbidden unless current_user.admin?
      end
    end
  end
end
