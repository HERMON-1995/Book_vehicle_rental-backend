class Api::V1::ReservationsController < ApplicationController
  def index
    render json: Reservation.order(id: :desc), status: :ok
  end

  def create
    reservation = Reservation.new(
      city: reservation_params[:city],
      reservation_date: reservation_params[:reservation_date],
      returned_date: reservation_params[:returned_date],
      user_id: reservation_params[:user_id],
      car_id: reservation_params[:car_id]
    )

    if reservation.save
      render json: {
        status: 201,
        message: 'Reservation is created',
        data: reservation
      }, status: :created
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def destroy
    reservation = Reservation.find_by(id: params[:id])

    if reservation
      if reservation.destroy
        render json: {
          status: 200,
          message: 'Reservation cancelled',
          data: reservation
        }, status: :ok
      else
        render json: { error: 'ERROR: Unable to cancel the reservation' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Reservation not found' }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(:city, :reservation_date, :returned_date, :user_id, :car_id)
  end
end
