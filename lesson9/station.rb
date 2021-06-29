# frozen_string_literal: true

require_relative 'instas_class_method'

# Station
class Station
  include InstanceCounter

  @@arr_stations = []

  attr_reader :trains
  attr_accessor :names

  def initialize(names)
    @names = names
    validate!
    @trains = []
    @@arr_stations << self
    self.class.all_station
    register_instance
  end

  count_instances

  def self.all_station
    @@arr_stations
  end

  def add_train(train)
    @trains << train unless trains.include?(train)
  end

  def print_train(trains, &block)
    block.call(trains)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise "Название не должно быть 'nil'" if names.nil?
    raise 'Название должно быть не менее 5 символов' unless names.length >= 5
  end
end
