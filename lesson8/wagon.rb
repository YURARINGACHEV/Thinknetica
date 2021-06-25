module CompanyMixin

  attr_accessor :name_company, :volume, :number, :volumes

end

#Класс вагон
class Wagon

  include CompanyMixin

  attr_accessor :type, :volumes, :volume, :number

  def initialize(number, type, volumes)
    @type = type.downcase
    @number = number
    validate!
    @volume = 0
    @volumes = volumes.to_i
  end

  def borrow(val)  
    raise "Вагон заполнен " unless @volume + val <= @volumes
    @volume = @volume +val 
  rescue RuntimeError => e
    puts "Error: #{e}"
  end

  def show_free
    @volumes - @volume
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