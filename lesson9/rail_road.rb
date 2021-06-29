# frozen_string_literal: true

# rail road
class RailRoad
  attr_reader :hash_wagon, :hash_train, :hash_station

  def initialize
    @hash_station = {}
    @hash_wagon = {}
    @hash_train = {}
  end

  def create_station
    puts 'Введите название станции (от 5 символов)'
    @count_station ||= 0
    @count_station += 1
    station = Station.new(gets.chomp)
    @hash_station[@count_station] = station
  end

  def choice_type
    puts "Введите тип 'pass' или 'cargo'"
    gets.chomp
  end

  def choice_number_train
    puts 'Введите номер поезда : xxx-xx (где x - произвольный символ)'
    gets.chomp
  end

  def create_pass_train
    @count_train ||= 0
    @count_train += 1
    train = PassengerTrain.new(choice_number_train, 'pass')
    @hash_train[@count_train] = train
  end

  def create_cargo_train
    @count_train ||= 0
    @count_train += 1
    train = CargoTrain.new(choice_number_train, 'cargo')
    @hash_train[@count_train] = train
  end

  def create_train
    case choice_type
    when 'pass'
      create_pass_train
    when 'cargo'
      create_cargo_train
    else
      create_train
    end
  end

  def choice_pass_wagon
    puts 'Введите номер пассажирского вагона '
    number = gets.chomp
    puts 'Введите количество мест в вагоне '
    PassengerWagon.new(number, 'pass', gets.chomp.to_i)
  end

  def add_pass_wagon(number_train)
    @hash_train[number_train].add_wagon(choice_pass_wagon)
  end

  def choice_cargo_wagon
    puts 'Введите номер грузового вагона '
    number = gets.chomp
    puts 'Введите количество мест в вагоне '
    CargoWagon.new(number, 'cargo', gets.chomp.to_i)
  end

  def add_cargo_wagon(number_train)
    @hash_train[number_train].add_wagon(choice_cargo_wagon)
  end

  def choice_pass_cargo_wagon
    puts "Выберите номер поезда #{@hash_train}"
    gets.chomp.to_i
  end

  def add_pass_cargo_wagon
    case @hash_train[number_train = choice_pass_cargo_wagon].type
    when 'pass'
      add_pass_wagon(number_train)
    when 'cargo'
      add_cargo_wagon(number_train)
    else
      add_pass_cargo_wagon
    end
  end

  def create_train_to_station
    puts "Выберите номер станции, чтобы добавить поезд #{@hash_station}"
    number_station = gets.chomp.to_i
    add_train_to_station(choice_pass_cargo_wagon, number_station)
  end

  def add_train_to_station(number_t, number_s)
    puts @hash_station[number_s].add_train(@hash_train[number_t]).to_s
  end

  def show_station
    @hash_station.each do |_num, station|
      puts "Станция #{station.names}"
    end
  end

  def show_station_train
    @hash_station.each do |_num, station|
      station.print_train(station.trains) do |x|
        x.each do |i|
          puts "№ Поезда #{i.number}, тип #{i.type}, вагоны #{i.wagons.length}"
        end
      end
    end
  end

  def show_train
    @hash_train.each do |_num, train|
      puts "Поезд #{train.number}"
    end
  end

  def show_train_wagon
    @hash_train.each do |_num, train|
      train.print_wagon(train.wagons) do |x|
        x.each do |i|
          puts "Поезд #{train.number}. Вагон #{i.number},тип вагона #{i.type}"
        end
      end
    end
  end
end
