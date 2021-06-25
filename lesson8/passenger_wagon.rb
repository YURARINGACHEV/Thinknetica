require_relative 'wagon'
class PassengerWagon < Wagon

	protected


  def validate! 
    raise "Тип должен быть pass'" unless type == 'pass'
  end

end