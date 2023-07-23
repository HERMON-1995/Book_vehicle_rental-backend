require 'rails_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { user: { username: 'testuser', password: 'password123' } } }

      it 'creates a new user' do
        post '/api/v1/users', params: valid_params

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')

      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { username: '', password: 'password123' } } }

      it 'returns unprocessable_entity status' do
        post '/api/v1/users', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Check if the response body contains the error message
        expect(response.body).to include('Username can\'t be blank')
      end
    end
  end
end
