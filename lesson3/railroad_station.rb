#создать класс Station:
class Station
    
  attr_reader :name, :trains

  #Название при создании
  def initialize(name)
    @name = name
    @trains = []
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


#класс поезд
class Train

  attr_reader :number, :type_train, :count_wagons, :current_speed

  #инициализация поезда
  def initialize(number, type_train, count_wagons)
    @number = number
    @type_train = type_train
    @count_wagons = count_wagons
    @current_speed = 0
  end

  #Может набирать скорость
  def speed_up(speed)
    @current_speed += speed
  end

  #Может тормозить
  def speed_down(speed)
    @current_speed -= speed
  end

  #Может прицеплять вагоны
  def add_wagons(wagon)
    @current_speed == 0? @count_wagons += wagon : puts("Остановите поезд. Скорость #{@current_speed}")
  end

  #Может отцеплять вагон
  def delete_wagons(wagon)
    (@current_speed == 0 && @count_wagons > 0)? @count_wagons -= wagon : puts("Остановите поезд. Скорость #{@current_speed}")
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

end 


# Класс маршрут
class Route
  
  attr_reader :stations

  # Инициализация нчальной и конечной станции
  def initialize(station_start, station_stop)
    @stations = [station_start, station_stop]
  end

  #добавление промежуточной станции
  def add_station(station)
    @stations.insert(1, station) unless stations.include?(station)

  end

  #Удаление станции
  def del_station(station)
    (station != @stations[0] && station != @stations[-1])? @stations.delete(station) : puts("Такой станции нет")
  end

  #Вывод станций
  def print_station
    @stations.each { |i| puts i }
  end

end

