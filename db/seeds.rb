# Clear existing data (optional, be careful in production!)
User.destroy_all
Category.destroy_all
Expense.destroy_all
Income.destroy_all
Budget.destroy_all

# Create Users
user1 = User.create!(
  first_name: "Alice",
  last_name: "Johnson",
  email: "alice@example.com",
  mobile_number: "+12345678901",
  password: "password123",
  password_confirmation: "password123"
)

user2 = User.create!(
  first_name: "Bob",
  last_name: "Smith",
  email: "bob@example.com",
  mobile_number: "+19876543210",
  password: "password123",
  password_confirmation: "password123"
)

# Create Categories (linked to users)
food = Category.create!(name: "Food", user: user1)
rent = Category.create!(name: "Rent", user: user1)
salary = Category.create!(name: "Salary", user: user1)
entertainment = Category.create!(name: "Entertainment", user: user2)

# Create Expenses for user1
Expense.create!(
  title: "Groceries",
  description: "Weekly grocery shopping",
  amount: 120.50,
  category: food,
  expense_date: Date.today - 3,
  payment_method: "Credit Card",
  user: user1
)

Expense.create!(
  title: "Monthly Rent",
  description: "Apartment rent",
  amount: 1000,
  category: rent,
  expense_date: Date.today - 15,
  payment_method: "Bank Transfer",
  user: user1
)

# Create Incomes for user1
Income.create!(
  title: "August Salary",
  amount: 3000,
  category: salary,
  income_date: Date.today - 10,
  user: user1
)

# Create Budgets for user1
Budget.create!(
  name: "August Food Budget",
  amount: 400,
  start_date: Date.today.beginning_of_month,
  end_date: Date.today.end_of_month,
  user: user1,
  category: food
)

# Create expenses and incomes for user2 as well if needed
Expense.create!(
  title: "Movie Tickets",
  description: "Cinema outing",
  amount: 30,
  category: entertainment,
  expense_date: Date.today - 2,
  payment_method: "Cash",
  user: user2
)


puts "Seed data created successfully!"
# This file contains the seed data for the application.
# It creates users, categories, expenses, incomes, and budgets for testing purposes.
# Be sure to run this file with `rails db:seed` to populate the database.
