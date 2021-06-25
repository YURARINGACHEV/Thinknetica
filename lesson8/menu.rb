class Menu

  def initialize
    @rail_road = RailRoad.new
  end

  def main_menu
    puts "главное меню"
    puts "Введите 0 чтобы выйти"
    puts "Введите 1 чтобы создать станцию, поезд, вагон"
    puts "Введите 2, если хотите порарботать с объектами"
    puts "Введите число"
    input = gets
    exit  if input.to_i == 0
    input.to_i
  end

  def choice_main_menu
    case main_menu
    when 1
      choice_create_rail_road	 
    when 2
      choice_actions_objects
    end 
  end

  def create_rail_road
    puts "Введите 0, если хотите вернуться в главное меню"
    puts "Введите 1, если хотите создать станцию"
    puts "Введите 2, если хотите создать поезд"
    puts "Введите 3, если хотите добавить или отцепить вагон"
    input = gets.chomp.to_i	
  end

  def choice_create_rail_road
    case create_rail_road
    when 1
      puts "Введите название станции (от 5 символов)"
      names = gets.chomp
      @rail_road.create_station(names)
      puts
    when 2
      puts "Введите номер поезда по примеру: xxx-xx (где x - произвольный символ)"
      number = gets.chomp 
      @rail_road.create_train(number)
      puts
    when 3
      puts "Выберите номер поезда, куда хотите добавить вагон #{@rail_road.hash_train}"	
      number_train = gets.chomp.to_i
      @rail_road.add_pass_cargo_wagon(number_train)
      puts
    when 0
      choice_main_menu
    else 
      choice_create_rail_road
    end
		choice_create_rail_road
  end
  
  def actions_objects
    puts "Введите 0, если хотите вернуться в главное меню "
    puts "Введите 1, если хотите добавить к станции поезд "
    puts "Введите 2, если хотите посмотреть список поездов на станции"
    puts "Введите 3, если хотите посмотреть поезда с вагонами "
    puts "Введите 4, если хотите посмотреть станции "
    puts "Введите 5, если хотите посмотреть поезда "
    input = gets.chomp.to_i
  end

  def choice_actions_objects
    case actions_objects
    when 1
      puts "Выберите номер поезда, который хотите добавить #{@rail_road.hash_train}"
      number_train = gets.chomp.to_i
      puts "Выберите номер станции, которой хотите добавить поезд #{@rail_road.hash_station}"
      number_station = gets.chomp.to_i
      @rail_road.add_train_on_station(number_train, number_station)
      puts
    when 2
      puts 
      @rail_road.show_station_train
      puts
    when 3
      puts 
      @rail_road.show_train_wagon
      puts
    when 4
      puts 
      @rail_road.show_station
      puts
    when 5
      puts 
      @rail_road.show_train
      puts
    when 0
      choice_main_menu
    else 
      choice_actions_objects
    end
      choice_actions_objects
  end
end
