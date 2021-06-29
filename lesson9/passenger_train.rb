# frozen_string_literal: true

require_relative 'train'
require_relative 'instas_class_method'

# passenger train
class PassengerTrain < Train
  include InstanceCounter

  def initialize(number, type)
    super(number, type)
    register_instance
  end

  count_instances

  def initial_speed
    150
  end

  protected

  def validate!
    super
    raise 'Тип должен быть pass' unless type == 'pass'
  end
end
