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
Input '8.' if you want to take a seat or volume in carriage\n
Input '9.' if you want to see list of stations and list of trains on stations"
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
    begin
      check_for_existing_station(station = create_station, array_of_stations)
      puts "You created station by name #{station.name}"
    rescue RuntimeError
      puts 'You entered wrong name format for your station. Try again'
    end
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
      check_for_existing_train(type_of_train(number), array_of_trains)
    rescue RuntimeError
      puts 'You entered wrong number format for your train. Try again'
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
  true if station_empty.zero?
end

def add_station_to_route(array_of_stations, route)
  loop do
    puts "You don't have enough stations, create more"; break if variants_for_add_route(array_of_stations, route)

    index_station = gets.chomp
    route.add_station(array_of_stations[index_station.to_i])
    puts "If you want to continue adding station to route input '+' otherwise entering will stop"
    enter_variable = gets.chomp
    break if enter_variable != '+'
  end
end

def get_train_position(array_of_train, &block)
  block.call
  array_of_train.each do |value|
    puts "Input: #{array_of_train.find_index(value)}
 for train's number #{value.number} type: #{value.class}"
  end
  gets.chomp.to_i
end

def input_number_of_seats
  puts 'Input number of seats for passenger railway carriage: '
  gets.chomp
end

def input_volume
  puts 'Input overall volume of cargo railway carriage: '
  gets.chomp
end

def show_instructions_type_of_carriage
  puts "\n"
  print "Input 'cargo' for carriage type cargo or"
  print " 'pass' for carriage type passenger"
  puts "\n"
end

def type_of_carriage_for_add(array_of_trains, train_position)
  show_instructions_type_of_carriage
  case gets.chomp
  when 'cargo'
    array_of_trains[train_position].add_wagon(RailwayCarriageCargo.new(input_volume.to_f))
  when 'pass'
    array_of_trains[train_position].add_wagon(PassengerRailwayCarriage.new(input_number_of_seats.to_i))
  else
    'You missed dialing, try again'
  end
end

def add_wagon_to_train(array_of_trains)
  loop do
    train_position = get_train_position(array_of_trains) { puts 'Select the train to which one you want to add wagon:' }
    type_of_carriage_for_add(array_of_trains, train_position)
    puts "If you want to continue adding carriages to trains input '+' otherwise entering will stop"
    enter_variable = gets.chomp
    break if enter_variable != '+'
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
  if arrays_of_train[train_position].temporary_station == nil
    route.stations[station_position].get_in_train(arrays_of_train[train_position])
    arrays_of_train[train_position].temporary_station = route.stations[station_position]
  else
    puts "You can't place this train, because it's
already on another station #{route.stations[station_position].name}"
  end
end

def inside_block_show_train(carriage, number, train)
  puts "\n"
  print "  Carriage by number #{number}, type #{train.class}"
  if carriage.instance_of? PassengerRailwayCarriage
    print " the number of free seats: #{carriage.free_seats},"
    print "the number of taken seats: #{carriage.number_of_taken_seats}"
  else
    print " the left volume: #{carriage.left_volume},"
    print "the occupied_volume: #{carriage.occupied_volume}"
  end
end

def show_train_info(train)
  print ' and this train has: '
  number = 1
  train.show_carriage_info do |carriage|
    inside_block_show_train(carriage, number, train)
    number += 1
  end
end

def show_station_info(station)
  station.show_trains do |train|
    print "Train number: #{train.number}, train type #{train.class},"
    print " number of railway carriages #{train.railway_carriages.length}"
    show_train_info(train)
    puts "\n"
  end
end

def show_stations(route)
  puts 'You have list of stations and trains, placed on them: '
  route.stations.each do |station|
    puts " On station #{station.name} you have these trains: "
    show_station_info(station)
    puts "\n"
  end
  puts "\n"
end

def select_carriage_for_taking(train)
  puts 'Firstly you should select carriage'
  train.show_carriage_info do |carriage|
    print " input #{train.railway_carriages.find_index(carriage)}"
    print " for carriage  #{train.railway_carriages.find_index(carriage) + 1}"
    puts "\n"
  end
  gets.chomp.to_i
end

def case_passenger_carriage(array_of_trains, train_position, carriage_position)
  if array_of_trains[train_position].railway_carriages[carriage_position].free_seats.positive?
    puts 'This is passenger train, so you can take a seat in selected carriage'
    array_of_trains[train_position].railway_carriages[carriage_position].take_seat
  else
    puts "You can't take a seat, because all are taken already"
  end
end

def case_cargo_carriage(array_of_trains, train_position, carriage_position)
  puts 'This is cargo train, so you can take up volume in selected carriage'
  puts "Input amount of volume, which you want to occupy,
 but it should be less than #{array_of_trains[train_position].railway_carriages[carriage_position].left_volume}"
  array_of_trains[train_position].railway_carriages[carriage_position].to_occupy_volume(gets.chomp.to_f)
end

def take_seat_or_volume(array_of_trains)
  train_position = get_train_position(array_of_trains) { puts 'Select train, in which one you want to make changes' }
  carriage_position = select_carriage_for_taking(array_of_trains[train_position])
  class_of_carriage = array_of_trains[train_position].railway_carriages[carriage_position].class
  if class_of_carriage == PassengerRailwayCarriage
    case_passenger_carriage(array_of_trains, train_position, carriage_position)
  else
    case_cargo_carriage(array_of_trains, train_position, carriage_position)
  end
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
    take_seat_or_volume(array_of_trains)
  when '9'
    show_stations(route)
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
