#Создать модуль, который позволит указывать 
#название компании-производителя и получать его. 
#Подключить модуль к классам Вагон и Поезд
module CompanyMixin

  # def name_companys(namme)
  #   self.name_company = namme
  # end
  
  # def show_campanys
  #   puts "Название компании #{self.name_company}"
  # end


  attr_accessor :name_company

end

#Класс вагон
class Wagon

  include CompanyMixin

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