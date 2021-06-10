#создать класс Station:

class Station
    
  attr_reader :trains, :name
  #Название при создании
  def initialize(name)
    @name = name
    @trains = []
  end

  #Добавление поездов
  def train_add(train)
    @trains << train
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
  attr_reader :number, :type_train, :count_wagons, :current_speed, :routes, :get_station, :last_station, :next_station, :current_station 
  #инициализация поезда
  def initialize(number, type_train, count_wagons, station)
    @number = number
    @type_train = type_train
    @count_wagons = count_wagons
    @current_station = station.name
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
  def add_route(route, station)
    @routes = route.stations
    #@index = route.stations.find_index(station.name)
    #@current_station = @routes[@index]
    @current_station = @routes[0]
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
    @index = @routes.find_index(@current_station)
    @last_station = @routes[@index-1]
  end

    #Возвращает текущую станцию
  def show_stations_current
    @index = @routes.find_index(@current_station)
    @current_station = @routes[@index]
  end

    #Возвращает следующую станцию
  def show_stations_next
    @index = @routes.find_index(@current_station)
    @next_station = @routes[@index + 1]
  end


end 


# Класс маршрут
class Route

  
  attr_reader :stations

  # Инициализация нчальной и конечной станции
  def initialize(start, stop)
    @stations = [start, stop]
  end

  #добавление промежуточной станции
  def add_station(station)
    @stations.insert(1, station.name)

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

