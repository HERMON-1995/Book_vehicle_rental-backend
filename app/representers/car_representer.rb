class CarRepresenter
  def initialize(car)
    @car = car
  end

  def as_json
    {
      id: @car.id,
      name: @car.name,
      description: @car.description,
      photo: @car.photo,
      price: @car.price,
      model: @car.model,
      user: @car.user_id, # Assign the user_id directly to the user key
      date_added: @car.created_at
    }
  end

  private

  attr_reader :car
end
