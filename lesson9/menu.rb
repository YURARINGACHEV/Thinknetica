# frozen_string_literal: true

# main menu
class Menu
  def initialize
    @rail_road = RailRoad.new
  end

  def main_menu
    puts 'главное меню'
    puts 'Введите 0 чтобы выйти'
    puts 'Введите 1 чтобы создать станцию, поезд, вагон'
    puts 'Введите 2, если хотите порарботать с объектами'
    puts 'Введите число'
    gets.chomp.to_i
  end

  def hash_main_menu(val)
    menus = { 0 => -> { exit }, 1 => -> { choice_create_rail_road },
              2 => -> { choice_actions_objects } }
    (menus[val] || choice_main_menu).call
  end

  def choice_main_menu
    hash_main_menu(main_menu)
  end

  def create_rail_road
    puts 'Введите 0, если хотите вернуться в главное меню'
    puts 'Введите 1, если хотите создать станцию'
    puts 'Введите 2, если хотите создать поезд'
    puts 'Введите 3, если хотите добавить или отцепить вагон'
    gets.chomp.to_i
  end

  def hash_first_menu(val)
    menus = { 0 => -> { choice_main_menu },
              1 => -> { @rail_road.create_station },
              2 => -> { @rail_road.create_train },
              3 => -> { @rail_road.add_pass_cargo_wagon } }
    (menus[val] || choice_create_rail_road).call
    puts
    choice_create_rail_road
  end

  def choice_create_rail_road
    hash_first_menu(create_rail_road)
  end

  def actions_objects
    puts 'Введите 0, если хотите вернуться в главное меню '
    puts 'Введите 1, если хотите добавить к станции поезд '
    puts 'Введите 2, если хотите посмотреть список поездов на станции'
    puts 'Введите 3, если хотите посмотреть поезда с вагонами '
    puts 'Введите 4, если хотите посмотреть станции '
    puts 'Введите 5, если хотите посмотреть поезда '
    gets.chomp.to_i
  end

  def hash_second_menu(val)
    menus = { 0 => -> { choice_main_menu },
              1 => -> { @rail_road.create_train_to_station },
              2 => -> { @rail_road.show_station_train },
              3 => -> { @rail_road.show_train_wagon },
              4 => -> { @rail_road.show_station },
              5 => -> { @rail_road.show_train } }
    (menus[val] || choice_actions_objects).call
    choice_actions_objects
  end

  def choice_actions_objects
    hash_second_menu(actions_objects)
  end
end
