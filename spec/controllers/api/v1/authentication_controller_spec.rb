require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe 'POST #create' do
    context 'with valid credentials' do
      it 'returns user information with status :created' do
        # Create a user instance using FactoryBot
        user = create(:user, username: 'test_user', password: 'password')

        # Perform the POST request with the created user's credentials
        post :create, params: { username: user.username, password: 'password' }

        expect(response).to have_http_status(:created)

        user_response = JSON.parse(response.body)
        expect(user_response['username']).to eq(user.username)
        expect(user_response).to have_key('id')
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized status' do
        # Perform the POST request with incorrect password
        post :create, params: { username: 'test_user', password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)

        error_response = JSON.parse(response.body)
        expect(error_response['error']).to eq('No such user; check the submitted username')
      end
    end

    context 'with missing username' do
      it 'returns unprocessable_entity status' do
        post :create, params: { password: 'password' }
        expect(response).to have_http_status(:unprocessable_entity)

        error_response = JSON.parse(response.body)
        expect(error_response['error']).to eq('param is missing or the value is empty: username')
      end
    end

    context 'with missing password' do
      it 'returns unprocessable_entity status' do
        # Create a user instance using FactoryBot
        user = create(:user, username: 'test_user', password: 'password')

        post :create, params: { username: user.username }
        expect(response).to have_http_status(:unprocessable_entity)

        error_response = JSON.parse(response.body)
        expect(error_response['error']).to eq('param is missing or the value is empty: password')
      end
    end
  end
end
