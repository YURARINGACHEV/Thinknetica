#Класс вагон
class Wagon

  attr_reader :type, :weight

  def initialize
    @type = ""
    @weight = 0
  end

  def wagon_weight
    wagon_weight!
  end

  def wagon_type
    wagon_type!
  end

  protected

  attr_writer :type, :weight

  def initial_type
    "Cargo or Passenger"
  end

  def wagon_type!
    self.type = initial_type
  end

  def initial_weight
    1000
  end

  def wagon_weight!
    self.weight = initial_weight
  end

end