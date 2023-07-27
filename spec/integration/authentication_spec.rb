require 'swagger_helper'
require 'factory_bot_rails'
require 'rswag/specs'

describe 'Authentication API', swagger_doc: 'v1/swagger.json' do
  include FactoryBot::Syntax::Methods

  before do
    # Create a user with the correct username and password using FactoryBot
    create(:user, username: 'emma', password: 'password123')
  end

  path '/api/v1/authentication' do
    post 'Authenticates a user' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response '401', 'Unauthorized' do
        let(:user) { { username: 'emma', password: 'wrongpassword' } }
        run_test! do |response|
          expect(response.body).to match(/No such user; check the submitted username/)
        end
      end

      response '201', 'Created' do
        let(:user) { { username: 'emma', password: 'password123' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['username']).to eq('emma') # Ensure that the 'username' field is correct
        end
      end
    end
  end
end
