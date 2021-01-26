require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'railway_carriage_cargo'
require_relative 'passenger_railway_carriage'

def list_choice
  puts "You have to choose operation:\n
Input '1.' if you want to create a station\n
Input '2.' if you want to create a route\n
Input '3.' if you want to add the station to the route\n
Input '4.' if you want to create train\n
Input '5.' if you want to add wagon to train\n
Input '6.' if you want to unhook wagon from train\n
Input '7.' if you want to place train on the station\n
Input '8.' if you want to see list of stations and list of trains on stations"
end

def create_station
  puts 'Input name of the station'
  name = gets.chomp
  Station.new(name)
end

def check_for_existing_station(station, array_of_stations)
  checker = true
  array_of_stations.each do |value|
    checker = false if value.name == station.name
  end
  if checker
    array_of_stations << station
  else
    puts "You can't create station with the same name"
  end
end

def add_station_to_array(array_of_stations)
  loop do
    station = create_station
    check_for_existing_station(station, array_of_stations)
    puts "If you want to continue creating stations input '+', otherwise the process will stop"
    break if gets.chomp != '+'
  end
end

def type_input
  puts "Choose the type of train, select '1' for cargo, '2' for passenger type"
  gets.chomp.to_i
end

def number_input
  puts 'Input number of train here: '
  gets.chomp
end

def case_type(type, number)
  case type
  when 1
    train = CargoTrain.new(number)
  when 2
    train = PassengerTrain.new(number)
  end
  train
end

def type_of_train(number)
  type = type_input
  case_type(type, number)
end

def check_for_existing_train(train, array_of_trains)
  checker = true
  array_of_trains.each do |value|
    checker = false if !train.nil? && !value.nil? && (value.number == train.number)
  end
  if checker
    array_of_trains << train
    puts "You created train by number #{train.number} and its type is #{train.class}"
  else
    puts "You can't create train with the same number"
  end
end

def create_train(array_of_trains)
  loop do
    number = number_input
    begin
      train = type_of_train(number)
      check_for_existing_train(train, array_of_trains)
    rescue RuntimeError
      puts 'You entered wrong number format. Try again'
    end
    puts "If you want to continue creating trains input '+', otherwise the process will stop"
    break if gets.chomp != '+'
  end
end

def begin_position_create_route(array_of_stations)
  puts 'Firstly choose the beginning of the route'
  array_of_stations.each do |station|
    puts "Input #{array_of_stations.find_index(station)}
for station #{station.name} "
  end
  gets.chomp
end

def end_position_create_route(begin_position, array_of_stations)
  puts 'Secondly choose the end of the route'
  array_of_stations.each do |station|
    if begin_position.to_i != array_of_stations.find_index(station)
      puts "Input #{array_of_stations.find_index(station)}
for station #{station.name} "
    end
  end
  gets.chomp
end

def show_instructions_create_route
  puts "If you want to create a route,
you should choose at least two stations for begin and end (they should be different!)"
end

def object_of_route(array_of_stations, route)
  begin_position = begin_position_create_route(array_of_stations)
  end_position = end_position_create_route(begin_position, array_of_stations)
  route.stations[0] = array_of_stations[begin_position.to_i]
  route.stations[1] = array_of_stations[end_position.to_i]
end

def create_route(array_of_stations, route)
  show_instructions_create_route
  if array_of_stations.length >= 2
    object_of_route(array_of_stations, route)
  else
    puts "You don't have enough stations, create more"
  end
  route
end

def find_station(station, route)
  result = true
  route.stations.each do |value|
    result = false if value.name == station.name
  end
  result
end

def variants_for_add_route(array_of_stations, route)
  station_empty = 0
  array_of_stations.each do |station|
    next unless find_station(station, route)

    puts "Input #{array_of_stations.find_index(station)}
    for station #{station.name}"
    station_empty += 1
  end
  puts 'Add more stations to your list' if station_empty.zero?
end

def add_station_to_route(array_of_stations, route)
  loop do
    variants_for_add_route(array_of_stations, route)
    index_station = gets.chomp
    route.add_station(array_of_stations[index_station.to_i])
    puts "If you want to continue adding station to route input '+' otherwise entering will stop"
    enter_variable = gets.chomp
    break if enter_variable != '+'
  end
end

def get_train_position_for_add_wagon(array_of_train)
  puts 'Select the train to which one you want to add wagon: '
  array_of_train.each do |value|
    puts "Input: #{array_of_train.find_index(value)}
 for train's number #{value.number} type: #{value.class}"
  end
  gets.chomp.to_i
end

def add_wagon_to_train(array_of_train)
  train_position = get_train_position_for_add_wagon(array_of_train)
  case array_of_train[train_position].class
  when 'CargoTrain'
    array_of_train[train_position].add_wagon(RailwayCarriageCargo.new)
  when 'PassengerTrain'
    array_of_train[train_position].add_wagon(PassengerRailwayCarriage.new)
  end
end

def delete_wagon(arrays_of_train)
  puts 'Select the train in which one you want to delete a wagon: '
  arrays_of_train.each do |value|
    puts "Input: #{arrays_of_train.find_index(value)}
 for train's number #{value.number} type: #{value.class}"
  end
  train_position = gets.chomp.to_i
  arrays_of_train[train_position].delete_wagon
end

def getting_station_position(route)
  puts 'Select the station to which one you want to add the train: '
  route.stations.each do |value|
    puts "Input: #{route.stations.find_index(value)}
 for station #{value.name}"
  end
  gets.chomp.to_i
end

def get_train_position_for_station(route, array_of_train, station_position)
  puts "Select the train which one you want to add to the #{route.stations[station_position].name}:"
  array_of_train.each do |value|
    puts "Input: #{array_of_train.find_index(value)}
 for train's number #{value.number} type: #{value.class}"
  end
  gets.chomp.to_i
end

def add_train_to_station(route, arrays_of_train)
  station_position = getting_station_position(route)
  train_position = get_train_position_for_station(route, arrays_of_train, station_position)
  route.stations[station_position].get_in_train(arrays_of_train[train_position])
  arrays_of_train[train_position].temporary_station = route.stations[station_position]
end

def all_cases(array_of_stations, array_of_trains, route, choice)
  case choice
  when '1'
    add_station_to_array(array_of_stations)
  when '2'
    create_route(array_of_stations, route)
  when '3'
    add_station_to_route(array_of_stations, route)
  when '4'
    create_train(array_of_trains)
  when '5'
    add_wagon_to_train(array_of_trains)
  when '6'
    delete_wagon(array_of_trains)
  when '7'
    add_train_to_station(route, array_of_trains)
  when '8'
    route.show_stations
  else
    puts 'Sorry, but you missed a bit, try again'
  end
end

def enter_variable_for_user_input
  puts "If you want to continue work with program '+', otherwise the process will stop"
  gets.chomp
end

def user_input
  array_of_trains = []
  array_of_stations = []
  route = Route.new
  loop do
    list_choice
    choice = gets.chomp
    all_cases(array_of_stations, array_of_trains, route, choice)
    break if enter_variable_for_user_input != '+'
  end
end

user_input
