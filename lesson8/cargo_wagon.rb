require_relative 'wagon'
class CargoWagon < Wagon
  

  protected

  def validate! 
    super
    raise "Тип должен быть pass'" unless type == 'cargo'
  end

end



