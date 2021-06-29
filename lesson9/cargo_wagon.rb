# frozen_string_literal: true

require_relative 'wagon'

# cargo wagon
class CargoWagon < Wagon
  protected

  def validate!
    super
    raise "Тип должен быть pass'" unless type == 'cargo'
  end
end
