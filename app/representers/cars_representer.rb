class CarsRepresenter
  def initialize(cars)
    @cars = cars
  end

  def as_json
    cars.map do |car|
      {
        user_id: car.id,
        name: car.name,
        description: car.description,
        photo: car.photo,
        price: car.price,
        model: car.model,
        user: car.user.username,
        date_added: car.created_at
      }
    end
  end

  private

  attr_reader :cars
end
