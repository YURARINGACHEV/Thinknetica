require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

$arr_station = {}
$count_station = 1
$arr_cargo_train = {}
$count_cargo_train = 1
$arr_pass_train = {}
$count_pass_train = 1
$arr_route = {}
$count_route = 1
$arr_cargo_wagon = {}
$count_cargo_wagon = 1
$arr_pass_wagon = {}
$count_pass_wagon = 1
$arr_station_list = {}
$arr_route_list = {}
$arr_cargo_train_list = {}
$arr_pass_train_list = {}
$arr_cargo_wagon_list = {}
$arr_pass_wagon_list = {}

def main_menu
	puts "главное меню"
	puts "Введите 0 чтобы выйти"
	puts "Введите 1 чтобы создать станцию, поезд, маршрут, вагон"
	puts "Введите 2, если хотите порарботать с объектами"
	puts "Введите число"
	input = gets
	exit  if input.to_i == 0
	return input.to_i
end




def create_rail_road
	puts "Введите 0, если хотите вернуться в главное меню"
	puts "Введите 1, если хотите создать станцию"
	puts "Введите 2, если хотите создать поезд"
	puts "Введите 3, если хотите создать маршрут"
	puts "Введите 4, если хотите создать вагон"
	input = gets
	case input.to_i
	when 1
		create_station
	when 2
		create_train
	when 3
		create_route
	when 4 
		create_wagon
	when 0
		return
	else 
		create_rail_road
	end
	create_rail_road
end

def actions_objects
	puts "Введите 0, если хотите вернуться в главное меню"
	puts "Введите 1, если хотите добавить или удалить стнцию в маршруте"
	puts "Введите 2, если хотите назначить маршрут поезду"
	puts "Введите 3, если хотите добавить к станции или отцепить поезд от станции"
	puts "Введите 4, если хотите перемещать поезд по маршруту вперед и назад"
	puts "Введите 5, если хотите добавить или отцепить вагон"
	puts "Введите 6, если хотите просматривать список станций и список поездов на станции"
	puts "Введите 7, если хотите просмотреть все созданные объекты"
	
	
	input = gets
	case input.to_i
	when 1
		del_add_station
	when 2
		add_route_train
	when 3
		del_add_train
	when 4 
		move_train
	when 5
		del_add_wagon
	when 6
		show_route_station
	#when 7
	#	show_create_objects
	when 0
		return
	else 
		actions_objects
	end
	actions_objects
end


def create_station
	puts "Введите название станции"
	names = gets.chomp
	station = Station.new(names)
	$arr_station[$count_station] = station
	$arr_station_list[$count_station] = station.name
	puts "Список станций#{$arr_station_list}"
	puts 
	$count_station +=1
end

def create_route
	puts "Введите начальную станцию"
	first_station = Station.new(gets.chomp)
	puts "Введите конечную станцию"
	last_station = Station.new(gets.chomp)
	route = Route.new(first_station, last_station)
	$arr_route[$count_route] = route
	$arr_route_list[$count_station] = route.stations
	print "Список маршрутов #{$arr_route_list}"
	puts
	$count_route += 1
end

def create_train
	puts "Введите тип поезда 'pass' или 'cargo'"
	type_train = gets.chomp.downcase
	case type_train
	when "pass"
		
		pass_train = PassengerTrain.new($count_pass_train)
		pass_train.assign_type
		pass_train.max_weight_train
		pass_train.max_speed_train
		$arr_pass_train[$count_pass_train] = pass_train
		$arr_pass_train_list[$count_pass_train] = pass_train.type_train
		$count_pass_train += 1
	when "cargo"
		cargo_train = CargoTrain.new($count_cargo_train)
		cargo_train.assign_type
		cargo_train.max_weight_train
		cargo_train.max_speed_train
		$arr_cargo_train[$count_cargo_train] = cargo_train
		$arr_cargo_train_list[$count_cargo_train] = cargo_train.type_train
		$count_cargo_train += 1		
	end
	puts "Список грузовых поездов #{$arr_cargo_train_list}"
	puts "Список пассажирских поездов #{$arr_pass_train_list}"
end

def create_wagon
	puts "Введите тип вагона 'pass' или 'cargo'"
	type_wagon = gets.chomp.downcase
	case type_wagon
	when "pass"
		pass_wagon = PassengerWagon.new
		pass_wagon.wagon_weight
		pass_wagon.wagon_type
		$arr_pass_wagon[$count_pass_wagon] = pass_wagon
		$arr_pass_wagon_list[$count_pass_wagon] = pass_wagon.type
		$count_pass_wagon += 1		
	when "cargo"
		cargo_wagon = CargoWagon.new
		cargo_wagon.wagon_weight
		cargo_wagon.wagon_type
		$arr_cargo_wagon[$count_cargo_wagon] = cargo_wagon
		$arr_cargo_wagon_list[$count_cargo_wagon] = cargo_wagon.type
		$count_cargo_wagon += 1		
	end
	puts "Список грузовых вагонов #{$arr_cargo_wagon_list}"
	puts "Список пассажирских вагонов #{$arr_pass_wagon_list}"
end

def del_add_station
	puts "Введите 'del', чтобы удалить или 'add', чтобы добавить станцию"
	del_add = gets.chomp
	case del_add
	when "add"
		puts "Выберите номер станци из списка #{$arr_station_list}"
		number_station = gets.chomp.to_i
		puts "Выберите номер маршрута, куда хотите добавить станцию #{$arr_route}"	
		number_route = gets.chomp.to_i
		puts "Новый маршрут #{$arr_route[number_route].add_station($arr_station[number_station])}"
		puts
	when "del"
		puts "Выберите номер станци из списка #{$arr_station_list}"
		number_station = gets.chomp.to_i
		puts "Выберите номер маршрута, откуда хотите удалить станцию #{$arr_route}"	
		number_route = gets.chomp.to_i
		puts "#{$arr_route[number_route].del_station($arr_station[number_station])}"
		puts
	end 
end

def del_add_train
	puts "Введите 'del', чтобы удалить или 'add', чтобы добавить поезд"
	del_add = gets.chomp
	case del_add
	when "add"
		puts "Выберите тип  поезда 'pass' или 'cargo'"
		type_train = gets.chomp
		
		if type_train == "cargo"
			puts "Выберите номер станции, куда хотите добавить поезд #{$arr_station_list}"	
			number_station = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_cargo_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_station[number_station].add_train($arr_cargo_train[number_train])}"
			puts  
		end
		if type_train == "pass"
			puts "Выберите номер станции, куда хотите добавить поезд #{$arr_station_list}"	
			number_station = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_pass_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_station[number_station].add_train($arr_pass_train[number_train])}"
			puts 
		end
	when "del"
		puts "Выберите тип  поезда 'cargo' или 'pass'"
		type_train = gets.chomp
		
		if type_train == "cargo"
			puts "Выберите номер станции, откуда хотите удалить поезд #{$arr_station_list}"	
			number_station = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_cargo_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_station[number_train].add_train($arr_cargo_train[number_train])}"
			puts
		end
		if type_train == "pass"
			puts "Выберите номер станции, откуда хотите удалить поезд #{$arr_station_list}"	
			number_station = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_pass_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_station[number_train].add_train($arr_pass_train[number_train])}"
			puts
		end
	end 
end

#Добавить отцепить вагон
def del_add_wagon
	puts "Введите 'del', чтобы удалить или 'add', чтобы добавить вагон"
	del_add = gets.chomp
	case del_add
	when "add"
		puts "Выберите тип  вагона"
		type_train = gets.chomp
		
		if type_train == "cargo"
			puts "Выберите номер поезда, куда хотите добавить вагон #{$arr_cargo_train_list}"	
			number_train = gets.chomp.to_i
			puts "Выберите номер вагона #{$arr_cargo_wagon_list}"
			number_wagon = gets.chomp.to_i
			puts "Вагон добавлен поезду "
			puts  "#{$arr_cargo_train[number_train].add_wagon($arr_cargo_wagon[number_wagon])}" 
		end
		if type_train == "pass"
			puts "Выберите номер поезда, куда хотите добавить вагон #{$arr_pass_train_list}"	
			number_train = gets.chomp.to_i
			puts "Выберите номер вагона #{$arr_pass_wagon_list}"
			number_wagon = gets.chomp.to_i
			puts "Вагон добавлен поезду "
			puts  "#{$arr_pass_train[number_train].add_wagon($arr_pass_wagon[number_wagon])}" 
		end
	when "del"
		puts "Выберите тип  вагона 'cargo' или 'pass'"
		type_train = gets.chomp
		
		if type_train == "cargo"
			puts "Выберите номер поезда, откуда хотите отцепить вагон #{$arr_cargo_train_list}"	
			number_train = gets.chomp.to_i
			puts "Выберите номер вагона #{$arr_cargo_wagon_list}"
			number_wagon = gets.chomp.to_i
			puts "Вагон отцеплен от поезда "
			puts  "#{$arr_cargo_train[number_train].delete_wagon($arr_cargo_wagon[number_wagon])}"
			
		end
		if type_train == "pass"
			puts "Выберите номер поезда, откуда хотите отцепить вагон #{$arr_pass_train_list}"	
			number_train = gets.chomp.to_i
			puts "Выберите номер вагона #{$arr_pass_wagon_list}"
			number_wagon = gets.chomp.to_i
			puts "Вагон отцеплен от поезда "
			puts  "#{$arr_pass_train[number_train].delete_wagon($arr_pass_wagon[number_wagon])}" 
		end
	end 
end


def add_route_train
	puts "Выберите тип  поезда 'pass' или 'cargo'" 
	type_train = gets.chomp
		
	if type_train == "cargo"
		puts "Выберите номер маршрута, чтобы назначить поезду #{$arr_route_list}"	
			number_route = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_cargo_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_cargo_train[number_train].add_route($arr_route[number_route])}"
			puts
		end
		if type_train == "pass"
			puts "Выберите номер маршрута, чтобы назначить поезду #{$arr_route_list}"	
			number_route = gets.chomp.to_i
			puts "Выберите номер поезда #{$arr_pass_train_list}"
			number_train = gets.chomp.to_i
			puts "Поезд добавлен #{$arr_pass_train[number_train].add_route($arr_route[number_route])}"
			puts
		end
end

# def show_create_objects
# 	puts
# 	puts "Список станций #{$arr_station_list}"
# 	puts "Список маршрутов #{$arr_route_list}"
# 	puts "Список грузовых поездов #{$arr_cargo_train_list}"
# 	puts "Список пассажирских поездов #{$arr_pass_train_list}"
# 	puts "Список грузовых вагонов #{$arr_cargo_wagon_list}"
# 	puts "Список пассажирских вагонов #{$arr_pass_wagon_list}"
# 	puts
# end

def move_train
	puts "Введите 'forward', если хотите переместить вперед или 'back', чтобы переместить назад"
	move = gets.chomp
	if move == 'forward'
		forward_train
	elsif move == 'back'
			back_train
	else
		puts "Вы ввели неправильные данные"
	end
end

def forward_train
	puts "Выберите номер поезда из списка, который хотите перместить по маршруту #{$arr_pass_train_list}"
	number_train = gets.chomp.to_i
	puts "Перемещен вперед #{$arr_pass_train[number_train].move_station_forward}"
end

def back_train
	puts "Выберите номер поезда из списка, который хотите перместить по маршруту #{$arr_pass_train_list}"
	number_train = gets.chomp.to_i
	puts "Перемещен назад  #{$arr_pass_train[number_train].move_station_back}"
end

def show_route_station
	show_route
	show_station
end

def show_route
	puts "Выберите номер маршрута из списка #{$arr_route_list}"
	number_route = gets.chomp.to_i
	puts "Все станции маршрута "
	puts
	$arr_route[number_route].print_station
end

def show_station
	puts "Выберите номер станции из списка #{$arr_station_list}"
	number_station = gets.chomp.to_i
	puts "Выберите тип  поезда 'pass' или 'cargo'"
	type_train = gets.chomp
	puts "#{$arr_station[number_station].print_train(type_train)}" 

end


loop do 

	case main_menu
	when 1
		create_rail_road	 
	when 2
		actions_objects
	end 
		
end
