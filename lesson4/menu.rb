class Menu

	def initialize
		@rail_road = RailRoad.new
	end

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

def choice_main_menu
		case self.main_menu
	when 1
		self.choice_create_rail_road	 
	when 2
		self.choice_actions_objects
	end 
end

def create_rail_road
	puts "Введите 0, если хотите вернуться в главное меню"
	puts "Введите 1, если хотите создать станцию"
	puts "Введите 2, если хотите создать поезд"
	puts "Введите 3, если хотите создать маршрут"
	puts "Введите 4, если хотите добавить или удалить вагон"
	input = gets.chomp.to_i	
end

def choice_create_rail_road
	case self.create_rail_road
	when 1
		puts "Число 1"
		@rail_road.create_station
		#create_station
	when 2
		puts "Число 2"
		@rail_road.create_train
		#create_train
	when 3
		puts "Число 3"
		@rail_road.create_route
		#create_route
	when 4 
		puts "Число 4"
		@rail_road.del_add_wagon
	# 	#create_wagon
	when 0
		self.choice_main_menu
	else 
		self.choice_create_rail_road
	end
	self.choice_create_rail_road

end

def actions_objects
	puts "Введите 0, если хотите вернуться в главное меню"
	puts "Введите 1, если хотите добавить или удалить станцию в маршруте"
	puts "Введите 2, если хотите назначить маршрут поезду"
	puts "Введите 3, если хотите добавить к станции или отцепить поезд от станции"
	puts "Введите 4, если хотите перемещать поезд по маршруту вперед и назад"
	puts "Введите 5, если хотите просматривать список станций и список поездов на станции"
	input = gets.chomp.to_i
end

def choice_actions_objects
	case self.actions_objects
	when 1
		puts "Число 1.1"
		@rail_road.del_add_station
	when 2
		@rail_road.add_route_train
	when 3
		puts "Число 1.3"
		@rail_road.del_add_train
	when 4 
		puts "Число 1.4"
		@rail_road.move_train
	when 5
		@rail_road.show_route_station
	when 0
		self.choice_main_menu
	else 
		self.choice_actions_objects
	end
	self.choice_actions_objects
end


end