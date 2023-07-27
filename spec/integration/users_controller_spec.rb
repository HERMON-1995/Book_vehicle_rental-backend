require 'rails_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            username: 'test_user',
            password: 'test_password'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post '/api/v1/users', params: valid_params
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Validate that the response body contains the user attributes
        expect(response.body).to include('test_user')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            username: nil,
            password: 'test_password'
          }
        }
      end

      it 'returns unprocessable_entity status' do
        post '/api/v1/users', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Validate that the response body contains the error message
        expect(response.body).to include("Username can't be blank")
      end
    end
  end
end
