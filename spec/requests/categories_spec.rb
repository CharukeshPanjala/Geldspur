require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  let!(:user) { create(:user, password: "password123") }

  before do
    login_as(user)
  end

  let!(:categories) { create_list(:category, 3, user: user) }
  let(:category) { categories.first }

  let(:valid_params) do
    {
      category: {
        name: "Utilities",
        description: "Monthly utility bills",
        category_type: "Expense",
        user_id: user.id
      }
    }
  end

  let(:invalid_params) do
    {
      category: {
        name: "",
        description: "x" * 300,
        category_type: "",
        user_id: nil
      }
    }
  end

  let(:base_url) { "/api/v1/categories" }

  describe "GET /categories" do
    it "returns all categories" do
      get base_url
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /categories/:id" do
    it "returns a specific category" do
      get "#{base_url}/#{category.id}"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["id"]).to eq(category.id)
      expect(json["name"]).to eq(category.name)
    end
  end

  describe "POST /categories" do
    context "with valid params" do
      it "creates a new category" do
        expect {
          post base_url, params: valid_params
        }.to change(Category, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post base_url, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /categories/:id" do
    it "updates the category" do
      put "#{base_url}/#{category.id}", params: { category: { name: "Updated Name" } }
      expect(response).to have_http_status(:ok)
      expect(category.reload.name).to eq("Updated Name")
    end
  end

  describe "DELETE /categories/:id" do
    it "deletes the category" do
      expect {
        delete "#{base_url}/#{category.id}"
      }.to change(Category, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
