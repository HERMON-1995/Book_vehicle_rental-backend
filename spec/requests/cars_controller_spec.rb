# spec/requests/cars_controller_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::CarsController', type: :request do
  describe 'GET #index' do
    it 'returns a successful response with all cars' do
      cars = create_list(:car, 3)

      get '/api/v1/cars'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')

      # Compare the JSON response with the expected JSON representation of the cars
      expect(response.body).to eq(CarsRepresenter.new(cars).as_json.to_json)
    end
  end

  describe 'POST #create with valid parameters' do
    let(:valid_attributes) do
      {
        name: 'Car Name',
        description: 'Car Description',
        photo: 'car.jpg',
        price: 10_000,
        model: 'Car Model',
        user_id: create(:user).id
      }
    end

    it 'creates a new car' do
      post '/api/v1/cars', params: valid_attributes
      expect(response).to have_http_status(:created)
    end
  end

  context 'with invalid parameters' do
    it 'returns unprocessable_entity status' do
      post '/api/v1/cars', params: { name: 'Test Car' } # Missing required parameters

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #index' do
    it 'returns a successful response with all cars' do
      cars = create_list(:car, 3)

      get '/api/v1/cars'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')

      # Compare the JSON response with the expected JSON representation of the cars
      expect(response.body).to eq(CarsRepresenter.new(cars).as_json.to_json)
    end
  end

  describe 'PUT #update' do
    it 'updates the car and returns no_content status' do
      car = create(:car)
      updated_params = { name: 'Updated Car', description: 'Updated car description' }

      put "/api/v1/cars/#{car.id}", params: updated_params

      expect(response).to have_http_status(:no_content)
      expect(car.reload.name).to eq(updated_params[:name])
      expect(car.reload.description).to eq(updated_params[:description])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the car and returns no_content status' do
      car = create(:car)

      delete "/api/v1/cars/#{car.id}"

      expect(response).to have_http_status(:no_content)
      expect(Car.exists?(car.id)).to be_falsey
    end

    it 'returns not_found status for a non-existent car' do
      delete '/api/v1/cars/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
