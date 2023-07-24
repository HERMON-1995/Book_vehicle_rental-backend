module Api
  module V1
    class CarsController < ApplicationController
      before_action :set_car, only: %i[update show destroy]
      # GET /cars
      def index
        @cars = Car.all
        render json: CarsRepresenter.new(@cars).as_json
      end

      # POST /car
      def create
        @car = Car.create(car_params)
        if @car.save
          render json: CarRepresenter.new(@car).as_json, status: :created
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      # GET /cars/:id
      def show
        render json: CarRepresenter.new(@car).as_json
      end

      # PUT /cars/:id
      def update
        @car.update(car_params)
        head :no_content
      end

      # DELETE /cars/:id
      def destroy
        @car = Car.find(params[:id])
        if @car.destroy
          render json: { 
            id: @car.id, 
            msg: 'Car deleted successfully' 
          }, status: :ok
        else
          render json: { error: 'Something went wrong' }, status: :bad_request
        end
      end

      private

      def car_params
        params.permit(:name, :description, :photo, :price, :model, :user_id)
      end

      def set_car
        @car = Car.find(params[:id])
      end
    end
  end
end
