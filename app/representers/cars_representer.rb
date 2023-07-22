class CarsRepresenter
  def initialize(cars)
    @cars = cars
  end

  def as_json
    cars.map do |car|
      {
        id: car.id,
        user_id: car.user_id,
        name: car.name,
        description: car.description,
        photo: car.photo,
        price: car.price,
        model: car.model,
        user: car.user.present? ? car.user.username : nil,
        date_added: car.created_at
      }
    end
  end

  private

  attr_reader :cars
end
