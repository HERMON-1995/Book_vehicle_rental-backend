require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "GET #index" do
    it "returns a list of reservations in descending order of ID" do
      # Create some test reservations with different IDs
      reservation1 = create(:reservation)
      reservation2 = create(:reservation)
      reservation3 = create(:reservation)

      # Make a GET request to the index action
      get :index

      # Expect the response status to be 200 (OK)
      expect(response).to have_http_status(:ok)

      # Parse the response JSON
      json_response = JSON.parse(response.body)

      # Expect the response to contain the reservations in descending order of ID
      expect(json_response.map { |r| r['id'] }).to eq([reservation3.id, reservation2.id, reservation1.id])
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new reservation" do
        user = create(:user)
        car = create(:car)

        # Parameters for the new reservation
        valid_params = {
          city: 'Test City',
          reservation_date: '2023-07-20',
          returned_date: '2023-07-21',
          user_id: user.id,
          car_id: car.id
        }

        # Make a POST request to the create action with the valid parameters
        post :create, params: valid_params

        # Expect the response status to be 201 (Created)
        expect(response).to have_http_status(:created)

        # Parse the response JSON
        json_response = JSON.parse(response.body)

        # Expect the response to include the success message and reservation data
        expect(json_response['status']).to eq(201)
        expect(json_response['message']).to eq('Reservation is created')
        expect(json_response['data']).to include('id', 'city', 'reservation_date', 'returned_date', 'user_id', 'car_id')

        # Expect the reservation to be created in the database
        expect(Reservation.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      it "returns an error message" do
        # Parameters with missing required fields
        invalid_params = {
          city: 'Test City',
          reservation_date: '2023-07-20'
        }

        # Make a POST request to the create action with the invalid parameters
        post :create, params: invalid_params

        # Expect the response status to be 400 (Bad Request)
        expect(response).to have_http_status(:bad_request)

        # Parse the response JSON
        json_response = JSON.parse(response.body)

        # Expect the response to contain the error message
        expect(json_response['error']).to eq('Something went wrong')

        # Expect no reservation to be created in the database
        expect(Reservation.count).to eq(0)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys a reservation" do
      # Create a test reservation
      reservation = create(:reservation)

      # Make a DELETE request to the destroy action with the reservation ID
      delete :destroy, params: { id: reservation.id }

      # Expect the response status to be 200 (OK)
      expect(response).to have_http_status(:ok)

      # Parse the response JSON
      json_response = JSON.parse(response.body)

      # Expect the response to include the success message and reservation data
      expect(json_response['status']).to eq(200)
      expect(json_response['message']).to eq('Reservation cancelled')
      expect(json_response['data']).to include('id', 'city', 'reservation_date', 'returned_date', 'user_id', 'car_id')

      # Expect the reservation to be destroyed in the database
      expect(Reservation.count).to eq(0)
    end

    it "returns an error message for invalid reservation ID" do
      # Make a DELETE request to the destroy action with an invalid reservation ID
      delete :destroy, params: { id: 999 }

      # Expect the response status to be 422 (Unprocessable Entity)
      expect(response).to have_http_status(:unprocessable_entity)

      # Parse the response JSON
      json_response = JSON.parse(response.body)

      # Expect the response to contain the error message
      expect(json_response['error']).to eq("Reservation not found")

      # Expect no reservation to be destroyed in the database
      expect(Reservation.count).to eq(0)
    end
  end
end
