# frozen_string_literal: true

require_relative 'instas_class_method'

# Route
class Route
  include InstanceCounter

  attr_accessor :instance
  attr_reader :stations

  count_instances

  def initialize(station_start, station_stop)
    @stations = [station_start, station_stop]
    register_instance
    validate!
  end

  def add_station(station)
    @stations.insert(1, station) unless stations.include?(station)
  end

  def del_station(station)
    @stations.delete(station) if not_del_first_last_station?(station)
  end

  def not_del_first_last_station?(station)
    station != @stations[0] && station != @stations[-1]
  end

  def print_station
    @stations.each { |i| puts i }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise '1 станция: Station' unless stations[0].instance_of?(Station)
    raise 'Конечная станция: Station' unless stations[-1].instance_of?(Station)
    raise 'Конечная не соответствует начальной' if stations[0] == stations[-1]
  end
end
