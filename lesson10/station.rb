# frozen_string_literal: true

require_relative 'instas_class_method'
require_relative 'validation'

# Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains
  attr_accessor :names

  NAME_STATION = /^[a-zа-я]/i.freeze

  validate :names, :presence
  validate :names, :format, NAME_STATION
  validate :names, :type, String

  def initialize(names)
    @names = names
    @trains = []
    validate!
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
end
