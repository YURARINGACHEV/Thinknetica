require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'
require_relative 'create_train'

creatr_train = CreateTrain.new

loop do 
	puts "Введите 0, если хотите выйти из программы  "
	puts "Введите 1, если хотите посмотреть список поездов "
	puts "Нажмите 'enter', чтобы продолжить "	
	input = gets.chomp 
	exit if input == '0'
	if input == '1' 
		print "#{creatr_train.arr_train}"
		puts
		puts
		next 
	end  
	puts
	puts "Введите номер поезда по примеру: xxx-xx (где x - произвольный символ)"
	creatr_train.number = gets.chomp
	puts "Введите тип поезда 'cargo' или 'pass'"
	creatr_train.type = gets.chomp
	puts "Создан поезд #{creatr_train.train}"
	puts

end