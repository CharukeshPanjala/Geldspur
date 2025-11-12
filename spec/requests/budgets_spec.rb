# spec/requests/budgets_spec.rb
require 'rails_helper'

RSpec.describe "Budgets API", type: :request do
  let!(:user) { create(:user, password: "password123") }

  before do
    login_as(user)
  end

  let!(:category) { create(:category, user: user, category_type: "expense") }
  let!(:budgets) { create_list(:budget, 3, user: user, category: category, amount: 1000.0, start_date: 5.days.ago, end_date: 5.days.from_now) }
  let(:budget) { budgets.first }

  let(:valid_params) do
    {
      budget: {
        name: "Monthly Budget",
        description: "Budget for groceries",
        amount: 2000.0,
        start_date: Date.current,
        end_date: Date.current + 30.days,
        user_id: user.id,
        category_id: category.id
      }
    }
  end

  let(:invalid_params) do
    {
      budget: {
        name: "",
        amount: -100,
        start_date: nil,
        end_date: nil,
        user_id: user.id,
        category_id: category.id
      }
    }
  end

  let(:base_url) { "/api/v1/budgets" }

  describe "GET /budgets" do
    it "returns all budgets" do
      get base_url
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
    end
  end

  describe "GET /budgets/:id" do
    it "returns a specific budget" do
      get "#{base_url}/#{budget.id}"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["id"]).to eq(budget.id)
      expect(json["amount"]).to eq(budget.amount)
    end
  end

  describe "POST /budgets" do
    context "with valid params" do
      it "creates a new budget" do
        expect {
          post base_url, params: valid_params
        }.to change(Budget, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["amount"]).to eq(2000.0)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post base_url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Name can't be blank", "Amount must be greater than or equal to 0", "Start date can't be blank", "End date can't be blank")
      end
    end
  end

  describe "PATCH /budgets/:id" do
    it "updates the budget" do
      patch "#{base_url}/#{budget.id}", params: { budget: { amount: 3000.0 } }
      expect(response).to have_http_status(:ok)
      expect(budget.reload.amount).to eq(3000.0)
    end
  end

  describe "DELETE /budgets/:id" do
    it "deletes the budget" do
      expect {
        delete "#{base_url}/#{budget.id}"
      }.to change(Budget, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
