# frozen_string_literal: true

require_relative 'instas_class_method'
require_relative 'validation'

# Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains
  attr_accessor :names, :attr_class 
 
  NAME_STATION = /^[a-zа-я]/i

  validate :names, :presence
  validate :names, :format, NAME_STATION
  validate :attr_class, :type, "Station"

  def initialize(names)
    @names = names
    
    @trains = []
    @attr_class = self.class.to_s
    validate!(self)
    self.class.add_train_or_staition(self)
    register_instance
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

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  protected

  # def validate!
  #   raise "Название не должно быть 'nil'" if names.nil?
  #   raise 'Название должно быть не менее 5 символов' unless names.length >= 5
  # end
end
