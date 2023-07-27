# app/representers/cars_representer.rb
class CarsRepresenter
  def initialize(cars)
    @cars = cars
  end

  def as_json
    @cars.map do |car|
      {
        id: car.id,
        user_id: car.user_id,
        name: car.name,
        description: car.description,
        photo: car.photo,
        price: car.price,
        model: car.model
      }
    end
  end
end
