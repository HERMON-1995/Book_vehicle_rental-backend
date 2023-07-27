require 'swagger_helper'

describe 'Reservations API', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/reservations' do
    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          city: { type: :string },
          date: { type: :string },
          time: { type: :string },
          duration: { type: :integer }
        },
        required: %w[city date time duration]
      }

      response '400', 'Bad Request' do
        let(:reservation) { { city: '', date: '2023-07-23', time: '09:00', duration: 2 } }
        run_test! do |response|
          expect(response.body).to match('{"error":"Something went wrong"}')
        end
      end
    end
  end
end
