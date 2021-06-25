class RailRoad

	attr_reader :hash_wagon, :hash_train, :hash_station

	def initialize
		@hash_station = {}
		@hash_wagon = {} 
		@hash_train = {}
		@count_train = 0
		@count_station = 0
		@count_wagon = 0
	end

	def create_station(names)
		@count_station += 1
		station = Station.new(names)
		@hash_station[@count_station] = station 
	end

	def choice_type
		puts "Введите тип 'pass' или 'cargo'"
		type = gets.chomp.downcase
	end

	def create_train(number)
		case self.choice_type
		when "pass"
			@count_train += 1
			train = PassengerTrain.new(number, 'pass')
			@hash_train[@count_train] = train
		when "cargo"
			@count_train += 1
			train = CargoTrain.new(number, 'cargo')
			@hash_train[@count_train] = train
		else
			self.choice_type
		end
		puts "Список поездов #{@hash_train}"
	end	


#Добавить и отцепить вагон
	def add_pass_cargo_wagon(number_train)
		
		if @hash_train[number_train].type == "pass"
			puts "Введите номер пассажирского вагона "
			number = gets.chomp
			puts "Введите количество мест в вагоне "
			number_place = gets.chomp.to_i
			wagon = PassengerWagon.new(number, 'pass', number_place)
			@hash_train[number_train].add_wagon(wagon)
		elsif @hash_train[number_train].type == "cargo"
			puts "Введите номер грузового вагона "
			number = gets.chomp
			puts "Введите объем вагона "
			number_volume = gets.chomp.to_i
			wagon = CargoWagon.new(number, 'cargo', number_volume)
			@hash_train[number_train].add_wagon(wagon)
		else 
			self.add_pass_cargo_wagon(number_place)
		end	
	end


	def add_train_on_station(number_train, number_station)
		puts "#{@hash_station[number_station].add_train(@hash_train[number_train])}"  
	end

	def show_station
		@hash_station.each do  |num, station| 
			puts  "Станция #{station.names}"
		end
	end

	def show_station_train
		@hash_station.each do  |num, station| 
			station.print_train(station.trains) { |x| x.each { |i| puts  "Станция #{station.names}, Номер поезда #{i.number}, тип поезда #{i.type}, вагоны #{i.wagons.length}"}}
		end
	end

	def show_train
		@hash_train.each do  |num, train| 
			puts  "Поезд #{train.number}"
		end
	end

	def show_train_wagon
		@hash_train.each do  |num, train| 
			train.print_wagon(train.wagons) { |x| x.each { |i| puts  "Поезд #{train.number}. Номер Вагона #{i.number}, тип вагона #{i.type}, начальный объем #{i.volumes}"}}
		end
	end

end