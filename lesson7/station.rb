require_relative 'instas_class_method'

#создать класс Station:
class Station

  include InstanceCounter
  
  #@@instance = 0
  @@arr_stations = []
    
  attr_reader  :trains
  attr_accessor :names

  # NAME_FORMAT = /\w/

  #Название при создании
  def initialize(names)
    @names = names
    @trains = []
    @@arr_stations << self
    self.class.all_station
    register_instance
    validate!
  end

  count_instances

  #Метод класса
  def self.all_station
    @@arr_stations
  end

  #Добавление поездов
  def add_train(train)
    @trains << train unless trains.include?(train)
    
  end

  # Возрат списка всех поездов
  def print_train(type_by_train)
    @trains.select { |train| train.type_train == type_by_train }
  end

  # Отправка поезда
  def send_train(train)
    @trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate! 

    raise "Название не должно быть 'nil'" if names.nil?
    raise "Название должно быть не менее 6 символов" if names.length < 6
    # raise "Название должно соответствовать формату" if names !~ NAME_FORMAT 

  end

end
