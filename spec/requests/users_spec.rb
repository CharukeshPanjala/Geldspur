require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:admin) { create(:user, role: "admin", password: "password123", password_confirmation: "password123") }
  let!(:user)  { create(:user, password: "password123", password_confirmation: "password123") }

  # helper to login a user via Devise in request specs
  before do
    post user_session_path, params: { user: { email: logged_in_user.email, password: "password123" } }
  end

  describe "GET /api/v1/users" do
    context "as admin" do
      let(:logged_in_user) { admin }

      it "returns all users" do
        get "/api/v1/users"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json.size).to eq(User.count)
      end
    end

    context "as normal user" do
      let(:logged_in_user) { user }

      it "denies access" do
        get "/api/v1/users"
        expect(response).to have_http_status(:forbidden)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Access denied")
      end
    end
  end

  describe "GET /api/v1/users/:id" do
    context "accessing own profile" do
      let(:logged_in_user) { user }

      it "returns user details" do
        get "/api/v1/users/#{user.id}"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(user.id)
      end
    end

    context "accessing another user's profile" do
      let(:logged_in_user) { user }

      it "denies access" do
        get "/api/v1/users/#{admin.id}"
        expect(response).to have_http_status(:forbidden)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Access denied")
      end
    end

    context "admin accessing any profile" do
      let(:logged_in_user) { admin }

      it "can access another user's profile" do
        get "/api/v1/users/#{user.id}"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(user.id)
      end
    end
  end

  describe "PUT /api/v1/users/:id" do
    let(:update_params) do
      { user: { first_name: "Updated", last_name: "Name" } }
    end

    context "user updating own profile" do
      let(:logged_in_user) { user }

      it "updates successfully" do
        put "/api/v1/users/#{user.id}", params: update_params
        expect(response).to have_http_status(:ok)
        expect(user.reload.first_name).to eq("Updated")
      end
    end

    context "user updating another profile" do
      let(:logged_in_user) { user }

      it "denies access" do
        put "/api/v1/users/#{admin.id}", params: update_params
        expect(response).to have_http_status(:forbidden)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Access denied")
      end
    end

    context "admin updating any profile" do
      let(:logged_in_user) { admin }

      it "updates successfully" do
        put "/api/v1/users/#{user.id}", params: update_params
        expect(response).to have_http_status(:ok)
        expect(user.reload.first_name).to eq("Updated")
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    context "admin deleting a user" do
      let(:logged_in_user) { admin }

      it "deletes successfully" do
        expect {
          delete "/api/v1/users/#{user.id}"
        }.to change(User, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "normal user trying to delete another user" do
      let(:logged_in_user) { user }

      it "denies access" do
        delete "/api/v1/users/#{admin.id}"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
