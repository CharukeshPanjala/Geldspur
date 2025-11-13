require 'rails_helper'

RSpec.describe "Expenses API", type: :request do
 let!(:user) { create(:user, password: "password123") }

  before do
    login_as(user)
  end

  let!(:category) { create(:category, user: user) }
  let!(:expenses) { create_list(:expense, 3, user: user, category: category) }
  let(:expense) { expenses.first }

  let(:valid_params) do
    {
      expense: {
        title: "Groceries",
        description: "Weekly grocery shopping",
        amount: 120.50,
        expense_date: Date.today,
        payment_method: "Cash",
        user_id: user.id,
        category_id: category.id
      }
    }
  end

  let(:invalid_params) do
    {
      expense: {
        title: "",
        amount: nil,
        expense_date: nil,
        payment_method: "",
        user_id: nil,
        category_id: nil
      }
    }
  end

  let(:base_url) { "/api/v1/expenses" }

  describe "GET /expenses" do
    it "returns all expenses" do
      get base_url
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /expenses/:id" do
    it "returns a specific expense" do
      get "#{base_url}/#{expense.id}"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["id"]).to eq(expense.id)
      expect(json["title"]).to eq(expense.title)
    end
  end

  describe "POST /expenses" do
    context "with valid params" do
      it "creates a new expense" do
        expect {
          post base_url, params: valid_params
        }.to change(Expense, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post base_url, params: invalid_params
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT /expenses/:id" do
    it "updates the expense" do
      put "#{base_url}/#{expense.id}", params: { expense: { title: "Updated Expense" } }
      expect(response).to have_http_status(:ok)
      expect(expense.reload.title).to eq("Updated Expense")
    end
  end

  describe "DELETE /expenses/:id" do
    it "deletes the expense" do
      expect {
        delete "#{base_url}/#{expense.id}"
      }.to change(Expense, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
