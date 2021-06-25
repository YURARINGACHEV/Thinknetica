require_relative 'train'
require_relative 'instas_class_method'

class CargoTrain < Train 
  
  include InstanceCounter

  def initialize(number, type)
    super(number, type)
    register_instance
  end

  count_instances

  def initial_speed
    100
  end

  protected 

  def validate!
    super
    raise "Тип должен быть cargo" unless type == 'cargo'
  end

end
