require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'


class InputTypeError < RuntimeError
end


class InputNumberError < RuntimeError
end


def input_number
  puts "Введите 0, если хотите выйти из программы  "
  puts "Введите номер поезда по примеру: xxx-xx (где x - произвольный символ)"
  puts
  input = gets.chomp 
end

def input_type
  puts "Введите тип поезда 'cargo' или 'pass'"
  puts
  input = gets.chomp
end

loop do
  begin
  	number = input_number 
    exit if number == '0'
    raise InputNumberError, "Номер не соответсвует формату xxx-xx " unless number  =~ /\w{3}-\w{2}/
    type = input_type
    raise InputTypeError, "Тип не соответствует " unless (type == 'cargo' || type == 'pass')
  rescue InputNumberError => e
    puts "Error: #{e.inspect}"
    puts
    retry
  rescue InputTypeError => e
    puts "Error: #{e.inspect}"
    puts
    retry
  end 
  puts
  puts "Создан поезд #{Train.new(number, type)}"
  puts
end





