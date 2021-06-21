
#создать класс Station:
class Station
    
  @@arr_stations = []
    
  attr_reader :name, :trains

  #Название при создании
  def initialize(name)
    @name = name
    @trains = []
    @@arr_stations << self
    self.class.all_station
    @@instance = register_instance(@@instance)
  end

  def class_method_instances
    self.class.instances(@@instance)
  end

  #Метод класса
  def self.all_station
    print "#{@@arr_stations}"
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

end
