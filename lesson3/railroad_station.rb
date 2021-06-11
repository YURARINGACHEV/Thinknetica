#создать класс Station:

class Station
    
  attr_reader :name, :trains
  #Название при создании
  def initialize(name)
    @name = name
    @trains = []
  end

  #Добавление поездов
  def train_add(train)
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
  attr_reader :number, :type_train, :count_wagons, :current_speed, :current_station 
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

  #Может возвращать 
  def current_speed
    @current_speed
  end

  #Может возвращать количество вагонов
  def count_wagons
    @count_wagons
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
    @routes = route.stations
    @current_station = @routes.first
    @current_station.train_add(self)
  end


  #Может перемещаться между станциями на одну вперед
  def move_station_forward
    @index = @routes.find_index(@current_station)
    @index += 1
    if @index < @routes.length 
      @current_station = @routes[@index]
     else
       puts "Поезд на конечной станции"
       @index = @routes.length - 1
       @current_station = @routes[@index]
     end
  end


   #Может перемещаться между станциями на одну назад
  def move_station_back
    @index = @routes.find_index(@current_station)
    @index -= 1
    if @index >= 0
      @current_station = @routes[@index]
     else
       puts "Поезд на первой станции"
       @index = 0
       @current_station = @routes[@index]
     end
  end

    #Возвращает предыдущую
  def show_stations_last
    @routes[@routes.find_index(@current_station) - 1]
  end

    #Возвращает текущую станцию
  def show_stations_current(route)
    route.stations.find { |station| station.trains.include?(self) }
    
  end

    #Возвращает следующую станцию
  def show_stations_next
    @routes[@routes.find_index(@current_station) + 1]
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

