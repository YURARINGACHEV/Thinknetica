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
