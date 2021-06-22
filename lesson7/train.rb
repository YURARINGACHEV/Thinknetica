require_relative 'instas_class_method'

module CompanyMixin

  attr_accessor :name_company

end


#класс поезд
class Train

  include InstanceCounter
  @@instance = 0
  @@hash_train = {}

  NUMBER_FORMAT = /\w{3}-\w{2}/

  include CompanyMixin

  attr_reader :number, :type, :current_speed, :max_speed, :max_weight, :wagons

  #инициализация поезда
  def initialize(number, type)
    @number = number
    @type = type.downcase
    @current_speed = 0
    @wagons = []
    @max_speed = 0
    @@instance += 1
    @@hash_train[@@instance] = self
    register_instance
    validate!
  end

  count_instances

  def self.find_train(number)
    @@hash_train[number]
  end

  #Может набирать скорость
  def speed_up
    if_max_speed?? set_speed : max_speed_train
   end

  def speed_down
    self.current_speed.zero?? dischare_speed : speed_zero
  end

  # Нобор максимальной скорости
  def if_max_speed?
    self.current_speed < max_speed_train
  end

  def if_zero_speed?
    validate_current_speed!
    self.current_speed.zero?
  end
    

  #Может прицеплять вагоны
  def add_wagon(wagon)
    self.wagons << wagon if (if_zero_speed? && type_pass_cargo?(wagon))
  end

  #Может отцеплять вагон
  def delete_wagon(wagon)
    (if_zero_speed?  && self.wagons.length > 0 && type_pass_cargo?(wagon))? self.wagons.delete_at(-1) : (puts "У поезда нет вагонов #{@wagons = []}")
  end 

  def type_pass_cargo?(wagon)
    validate_type!(wagon)
    self.type == wagon.type
  end

  
  #Может принимать маршрут следования маршрута(Route)
  #Автоматически ставится на первую станцию
  def add_route(route)
    @routes = route
    @routes.stations.first.add_train(self)
  end

  #Может перемещаться между станциями на одну вперед
  def move_station_forward
    return unless station_next
    destination_station = station_next
    station_current.send_train(self)
    destination_station.add_train(self)
  end

   #Может перемещаться между станциями на одну назад
  def move_station_back
    return unless previous_station
    destination_station = previous_station
    station_current.send_train(self)
    destination_station.add_train(self)
  end

    #Возвращает текущую станцию
  def station_current
    @routes.stations.find { |station| station.trains.include?(self) }
  end

  def current_station_index
    @routes.stations.index(station_current)
  end

    #Возвращает следующую станцию
  def station_next
     @routes.stations[current_station_index + 1] if current_station_index < @routes.stations.length
  end

  #Возращает
  def previous_station
    @routes.stations[current_station_index - 1] if current_station_index > 0
  end

  def max_speed_train
    max_speed_train!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  attr_writer :type_train, :max_speed, :current_speed

  def validate! 

    raise "Тип и номер не должны быть 'nil'" if (type.nil? && number.nil?)
    raise "Формат номера не совподает " unless number =~ NUMBER_FORMAT
    raise "Тип должен быть 'cargo' или 'pass'" unless (type == 'cargo' || type == 'pass')
    
  end

  def validate_type!(wagon)
    raise "Тип поезда и вагона должны совподать" unless self.type == wagon.type
  end

  def validate_current_speed!
    raise "Остановите поезд " unless self.current_speed == 0
  end

  def initial_speed
    100
  end

  def speed_zero
    self.current_speed = 0
  end

  def max_speed_train!
    self.max_speed = initial_speed
  end

  def set_speed
    self.current_speed = self.current_speed + 1
  end

  def dischare_speed
    self.current_speed = self.current_speed - 1
  end

end 


