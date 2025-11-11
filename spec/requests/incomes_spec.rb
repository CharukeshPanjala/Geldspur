require 'rails_helper'

RSpec.describe "Incomes API", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:incomes) { create_list(:income, 3, user: user, category: category) }
  let(:income) { incomes.first }

  let(:valid_params) do
    {
      income: {
        title: "Freelance Project",
        description: "Payment for freelance work",
        amount: 1500.50,
        income_date: "2024-01-15",
        payment_method: "Bank Transfer",
        user_id: user.id,
        category_id: category.id
      }
    }
  end

  let(:invalid_params) do
    {
      income: {
        title: nil,
        amount: nil,
        income_date: nil,
        payment_method: nil,
        user_id: user.id,
        category_id: category.id
      }
    }
  end

  let(:base_url) { "/api/v1/incomes" }

  describe "GET /incomes" do
    it "returns all incomes" do
      get base_url
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
      expect(json.first["id"]).to eq(income.id)
    end
  end

  describe "GET /incomes/:id" do
    it "returns a specific income" do
      get "#{base_url}/#{income.id}"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["id"]).to eq(income.id)
      expect(json["amount"]).to eq(income.amount)
      expect(json["title"]).to eq(income.title)
    end
  end

  describe "POST /incomes" do
    context "with valid params" do
      it "creates a new income" do
        expect {
          post base_url, params: valid_params
        }.to change(Income, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Freelance Project")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post base_url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Title can't be blank")
      end
    end
  end

  describe "PATCH /incomes/:id" do
    it "updates the income" do
      patch "#{base_url}/#{income.id}", params: { income: { amount: 999.99 } }

      expect(response).to have_http_status(:ok)
      expect(income.reload.amount).to eq(999.99)
    end
  end

  describe "DELETE /incomes/:id" do
    it "deletes the income" do
      expect {
        delete "#{base_url}/#{income.id}"
      }.to change(Income, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
