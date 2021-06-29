# frozen_string_literal: true

# rail road
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

  def create_station
    puts 'Введите название станции (от 5 символов)'
    @count_station += 1
    station = Station.new(gets.chomp)
    @hash_station[@count_station] = station
  end

  def choice_type
    puts "Введите тип 'pass' или 'cargo'"
    gets.chomp
  end

  def choice_number_train
    puts 'Введите номер поезда по примеру: xxx-xx (где x - произвольный символ)'
    gets.chomp
  end

  def create_pass_train
    @count_train += 1
    train = PassengerTrain.new(choice_number_train, 'pass')
    @hash_train[@count_train] = train
  end

  def create_cargo_train
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

  def add_pass_wagon(number_train)
    puts 'Введите номер пассажирского вагона '
    number = gets.chomp
    puts 'Введите количество мест в вагоне '
    number_place = gets.chomp.to_i
    wagon = PassengerWagon.new(number, 'pass', number_place)
    @hash_train[number_train].add_wagon(wagon)
  end

  def add_cargo_wagon(number_train)
    puts 'Введите номер грузового вагона '
    number = gets.chomp
    puts 'Введите объем вагона '
    number_volume = gets.chomp.to_i
    wagon = CargoWagon.new(number, 'cargo', number_volume)
    @hash_train[number_train].add_wagon(wagon)
  end

  def add_pass_cargo_wagon
    puts "Выберите номер поезда, куда хотите добавить вагон #{@hash_train}"
    number_train = gets.chomp.to_i
    case @hash_train[number_train].type
    when 'pass'
      add_pass_wagon(number_train)
    when 'cargo'
      add_cargo_wagon(number_train)
    else
      add_pass_cargo_wagon
    end
  end

  def create_train_to_station
    puts "Выберите номер поезда, который хотите добавить #{hash_train}"
    number_train = gets.chomp.to_i
    puts "Выберите номер станции, которой хотите добавить поезд #{hash_station}"
    number_station = gets.chomp.to_i
    add_train_to_station(number_train, number_station)
    puts
  end

  def add_train_to_station(number_train, number_station)
    puts @hash_station[number_station].add_train(@hash_train[number_train]).to_s
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
          puts "Станция #{station.names}, Номер поезда #{i.number},"\
               "тип поезда #{i.type}, вагоны #{i.wagons.length}"
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
          puts "Поезд #{train.number}. Номер Вагона #{i.number}," \
               " тип вагона #{i.type}, начальный объем #{i.volumes}"
        end
      end
    end
  end
end
