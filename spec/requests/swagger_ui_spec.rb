require 'rails_helper'

RSpec.describe 'SwaggerUis', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/swagger_ui/index'
      expect(response).to have_http_status(:success)
    end
  end
end
