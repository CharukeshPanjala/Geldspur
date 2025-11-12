RSpec.configure do |config|
  # Include Devise test helpers for request specs
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Optionally include FactoryBot shorthand
  config.include FactoryBot::Syntax::Methods
end
