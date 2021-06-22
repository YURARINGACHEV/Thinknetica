#Создать модуль, который позволит указывать 
#название компании-производителя и получать его. 
#Подключить модуль к классам Вагон и Поезд
module CompanyMixin

  attr_accessor :name_company

end

#Класс вагон
class Wagon

  include CompanyMixin

  attr_accessor :type

  def initialize(type)
    @type = type.downcase
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate! 

    raise "Название не должно быть 'nil'" if type.nil?
    raise "Тип должен быть 'cargo' или 'pass'" unless (type == 'cargo' || type == 'pass')
    
  end

end