# frozen_string_literal: true

require_relative 'instas_class_method'
require_relative 'company_mixin'

# train
class Train
  include CompanyMixin
  include InstanceCounter
  @@instance = 0
  @@hash_train = {}

  NUMBER_FORMAT = /\w{3}-\w{2}/.freeze

  attr_reader :number, :type, :current_speed,
              :max_speed, :max_weight, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @current_speed = 0
    @wagons = []
    @max_speed = 0
    @@instance += 1
    @@hash_train[@@instance] = self
    register_instance
  end

  count_instances

  def self.find_train(number)
    @@hash_train[number]
  end

  def speed_up
    if_max_speed? ? set_speed : max_speed_train
  end

  def speed_down
    current_speed.zero? ? dischare_speed : speed_zero
  end

  def if_max_speed?
    current_speed < max_speed_train
  end

  def if_zero_speed?
    validate_current_speed!
    current_speed.zero?
  end

  def add_wagon(wagon)
    (@wagons << wagon unless wagons.include?(wagon)) if if_zero_and_type?(wagon)
  end

  def delete_wagon(wagon)
    if_zero_and_type?(wagon) && wagons.length.positive? ? wagons.delete_at(-1) : @wagons = []
  end

  def if_zero_and_type?(wagon)
    if_zero_speed? && type_pass_cargo?(wagon)
  end

  def type_pass_cargo?(wagon)
    validate_type!(wagon)
    type == wagon.type
  end

  def print_wagon(wagons, &block)
    block.call(wagons)
  end

  def add_route(route)
    @routes = route.stations
    @routes.first.add_train(self)
  end

  def move_station_forward
    return unless station_next

    destination_station = station_next
    station_current.send_train(self)
    destination_station.add_train(self)
  end

  def move_station_back
    return unless previous_station

    destination_station = previous_station
    station_current.send_train(self)
    destination_station.add_train(self)
  end

  def station_current
    @routes.find { |station| station.trains.include?(self) }
  end

  def index_stattion
    @routes.index(station_current)
  end

  def station_next
    @routes[index_stattion + 1] if index_stattion < @routes.length
  end

  def previous_station
    @routes[index_stattion - 1] if index_stattion.positive?
  end

  def max_speed_train
    max_speed_train!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  attr_writer :type_train, :max_speed, :current_speed

  def validate!
    raise "Тип и номер не должны быть 'nil'" if type.nil? && number.nil?
    raise 'Формат номера не совподает ' unless number =~ NUMBER_FORMAT
  end

  def validate_type!(wagon)
    raise 'Тип поезда и вагона должны совподать' unless type == wagon.type
  end

  def validate_current_speed!
    raise 'Остановите поезд ' unless current_speed.zero?
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
    self.current_speed = current_speed + 1
  end

  def dischare_speed
    self.current_speed = current_speed - 1
  end
end
