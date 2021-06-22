require_relative 'instas_class_method'

 #Класс маршрут
class Route
  include InstanceCounter
    
  attr_accessor :instance
  attr_reader :stations
  
  count_instances

  # Инициализация нчальной и конечной станции
  def initialize(station_start, station_stop)
    @stations = [station_start, station_stop]
    register_instance
    validate!
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate! 

    raise "Название не должно быть 'nil'" if stations[0].nil?
    raise "Первая станция дожна быть классом Station" unless stations[0].class == Station
    raise "Конечная станция дожна быть классом Station" unless stations[-1].class == Station
    raise "Конечная и начальная станции должны отличаться" if stations[0] == stations[-1]
    
  end

end
