# frozen_string_literal: true

require_relative 'wagon'

# passenger wagon
class PassengerWagon < Wagon
  protected

  def validate!
    raise "Тип должен быть pass'" unless type == 'pass'
  end
end
