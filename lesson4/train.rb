#класс поезд
class Train

  attr_reader :number, :type_train, :current_speed, :max_speed, :max_weight, :wagons

  #инициализация поезда
  def initialize(number)
    @number = number
    @type_train = ""
    @current_speed = 0
    @wagons = []
    @max_speed = 0
  end

  #Может набирать скорость
  def speed_up
    if_max_speed?? set_speed : max_speed_train
   end

  def speed_down
    if_zero_speed?? dischare_speed : speed_zero
  end

  # Нобор максимальной скорости
  def if_max_speed?
    self.current_speed < max_speed_train
  end

  def if_zero_speed?
    !self.current_speed.zero?
  end
    

  #Может прицеплять вагоны
  def add_wagon(wagon)
    (self.current_speed.zero? && count_wagons_weight(wagon) < max_weight && type_pass_cargo?(wagon))? self.wagons << wagon : self.wagons
  end

  #Может отцеплять вагон
  def delete_wagon(wagon)
    (current_speed.zero? && self.wagons.length > 0 && type_pass_cargo?(wagon))? self.wagons.delete_at(-1) : @wagons = []
  end

  def count_wagons_weight(wagon)
    self.wagons.length * wagon.weight
  end

  def type_pass_cargo?(wagon)
    self.type_train == wagon.type
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

  def assign_type
    assign_type!
  end

  def max_weight_train
    max_weight_train!
  end

  def max_speed_train
    max_speed_train!
  end

  protected

  attr_writer :type_train, :max_speed, :current_speed, :max_weight

  def initial_max_weight_train
    10000
  end

  def max_weight_train!
    self.max_weight = initial_max_weight_train
  end

  def initial_type
    "Cargo or pessenger"
  end

  #Присвоение типа. Тип вагона не будет меняться.
  def assign_type!
    self.type_train = initial_type
  end

  def initial_speed
    10
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


