require 'swagger_helper'

describe 'Cars API', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/cars' do
    post 'Creates a car' do
      tags 'Cars'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :integer },
          name: { type: :string },
          model: { type: :string },
          description: { type: :string },
          photo: { type: :string }
        },
        required: ['user', 'name', 'model', 'description', 'photo']
      }

      response '422', 'Unprocessable Entity' do
        let(:car) { { user: 1, name: '', model: 'Model X', description: 'Electric car', photo: 'car.jpg' } }
        run_test! do |response|
          expect(response.body).to match(/"name":\["can't be blank"\]/)
        end
      end
    end
  end
end
