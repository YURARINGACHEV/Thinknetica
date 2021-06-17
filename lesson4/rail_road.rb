class RailRoad

	def initialize
		@arr_station = {}
		@arr_route = {}
		@arr_train = {}
		@count = 0
		@count_station = 0
		@count_route = 0
	end

	def create_station
		@count_station += 1
		puts "Введите название станции"
		names = gets.chomp
		station = Station.new(names)
		@arr_station[@count_station] = station
		puts "Список станций #{@arr_station}"
		puts 
	end

	def create_route
		@count_route += 1
		puts "Введите начальную станцию"
		first_station = Station.new(gets.chomp)
		puts "Введите конечную станцию"
		last_station = Station.new(gets.chomp)
		route = Route.new(first_station, last_station)
		@arr_route[@count_route] = route
		print "Список маршрутов #{@arr_route}"
		puts
	end	

	def create_train
	
		#puts "Введите номер поезда"
		#number_train = gets.chomp
		case self.choice_type
		when "pass"
			@count += 1
			pass_train = PassengerTrain.new(@count)
			pass_train.assign_type
			pass_train.max_weight_train
			pass_train.max_speed_train
			@arr_train[@count] = pass_train
		when "cargo"
			@count += 1
			cargo_train = CargoTrain.new(@count)
			cargo_train.assign_type
			cargo_train.max_weight_train
			cargo_train.max_speed_train
			@arr_train[@count] = cargo_train
		else
			self.choice_type
		end
		puts "Список поездов #{@arr_train}"
	end

	def del_add_station
	puts "Введите 'del' чтобы удалить. 'add' чтобы добавить станцию"
	del_add = gets.chomp
	case del_add
	when "add"
		number_station = choice_number("станции", @arr_station)	
		number_route = choice_number("маршрута", @arr_route)
		puts "Новый маршрут #{@arr_route[number_route].add_station(@arr_station[number_station])}"
		puts
	when "del"
		number_station = choice_number("станции", @arr_station)	
		number_route = choice_number("маршрута", @arr_route)
		puts "#{@arr_route[number_route].del_station(@arr_station[number_station])}"
		puts
	end 
end


	def choice_type
		puts "Введите тип 'pass' или 'cargo'"
		type = gets.chomp.downcase
	end

	def choice_del_add
		puts "Введите 'del', чтобы удалить или 'add', чтобы добавить "
		del_add = gets.chomp
	end
#Добавить и отцепить вагон
	def choice_add_type_pass_cargo
		puts "Выберите номер поезда, куда хотите добавить вагон #{@arr_train}"	
		number_train = gets.chomp.to_i
		if @arr_train[number_train].type_train == "pass"
			wagon = PassengerWagon.new
			wagon.wagon_weight
			wagon.wagon_type
			puts "Вагон #{wagon}"
			puts  "#{@arr_train[number_train].add_wagon(wagon)}"
			puts "Вагон добавлен поезду pass #{@arr_train[number_train]}" 
			puts "тип воезда #{@arr_train[number_train].type_train}"
		elsif @arr_train[number_train].type_train == "cargo"
			wagon = CargoWagon.new
			wagon.wagon_weight
			wagon.wagon_type
			puts "Вагон #{wagon}"
			puts  "#{@arr_train[number_train].add_wagon(wagon)}" 
			puts "Вагон добавлен поезду cargo #{@arr_train[number_train]}"
			puts "тип воезда #{@arr_train[number_train].type_train}"	
		else 
			self.choice_add_type_pass_cargo
		end	
	end


	def choice_del_type_pass_cargo
		puts "Выберите номер поезда, чтобы отцепить вагон #{@arr_train}"	
		number_train = gets.chomp.to_i
		if @arr_train[number_train].type_train == "pass"
			wagon = PassengerWagon.new
			wagon.wagon_weight
			wagon.wagon_type
			puts "Вагон удален поезда pass"
			puts  "#{@arr_train[number_train].delete_wagon(wagon)}" 
		elsif @arr_train[number_train].type_train == "cargo"
			wagon = CargoWagon.new
			wagon.wagon_weight
			wagon.wagon_type
			puts "Вагон удален у поезда cargo"
			puts  "#{@arr_train[number_train].delete_wagon(wagon)}" 
		else 
			self.choice_del_type_pass_cargo	
		end	
	end


	def del_add_wagon
		case choice_del_add
		when "add"
			self.choice_add_type_pass_cargo
			#self.choice_add_type_cargo	
		when "del"
			self.choice_del_type_pass_cargo
			#self.choice_del_type_cargo
		end 
	end

	#Добавить и удалить станцию

	def choice_number(names, val)
		puts "Выберите номер #{names} #{val}"	
		number = gets.chomp.to_i
	end	


	def del_add_train
	case choice_del_add
	when "add"
		type_train = choice_type
		if type_train == "cargo"
			train = @arr_train.detect{|i, train| train.type_train == "cargo"}
			print "Pass #{train}"
			number_station = choice_number("станции", @arr_station)
			number_train = choice_number("поезда", train)
			puts "Поезд добавлен #{@arr_station[number_station].add_train(train[number_train])}"
			puts  
		end
		if type_train == "pass"
			train = @arr_train.detect{|i, train|  train.type_train == "pass"}
			print "Pass #{train}"
			number_station = choice_number("станции", @arr_station)
			number_train = choice_number("поезда", train)
			puts "Поезд добавлен #{@arr_station[number_station].add_train(train[number_train])}"
			puts
		end
	when "del"
		type_train = choice_type
		if type_train == "cargo"
			train = @arr_train.find_all{|train| train.type_train == "cargo"}
			print "Pass #{train}"
			number_station = choice_number("станции", @arr_station)
			number_train = choice_number("поезда", train)
			puts "Поезд удален #{@arr_station[number_station].send_train(train[number_train])}"
			puts  
		end
		if type_train == "pass"
			train = @arr_train.find_all{|train| train.type_train == "pass"}
			print "Pass #{train}"
			number_station = choice_number("станции", @arr_station)
			number_train = choice_number("поезда", train)
			puts "Поезд удален #{@arr_station[number_station].send_train(train[number_train])}"
			puts
		end
	end
	end
	def show_route
		number_route = choice_number("маршрута", @arr_route)
		puts "Все станции маршрута "
		puts
		@arr_route[number_route].print_station
	end

	def show_station
		number_station = choice_number("станции", @arr_station)
		type_train = choice_type
		puts "#{@arr_station[number_station].print_train(type_train)}" 

	end	
	def show_route_station
		show_route
		show_station
	end


	def add_route_train
		number_route = choice_number("маршрута", @arr_route)
		number_train = choice_number("поезда", @arr_train)
		puts "Поезд добавлен #{@arr_train[number_train].add_route(@arr_route[number_route])}"
		puts
	end
#перемещение поездов
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
		number_train = choice_number("поезда", @arr_train)
		puts "Перемещен вперед #{@arr_pass_train[number_train].move_station_forward}"
	end

	def back_train
		number_train = choice_number("поезда", @arr_train)
		puts "Перемещен назад  #{@arr_train[number_train].move_station_back}"
	end
end




