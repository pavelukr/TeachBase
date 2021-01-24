require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'

def list_choice
  puts "You have to choose operation:\n
Input '1.' if you want to create train\n
Input '2.' if you want to add wagon to train\n
Input '3.' if you want to unhook wagon from train\n
Input '4.' if you want to place train on the station\n
Input '5.' if you want to see list of stations and list of trains on stations\n
Input '0.' if you want to stop\n"
end

def create_train(route)
  puts "Choose the type of train, select '1' for cargo, '2' for passenger type"
  type = gets.chomp.to_i
  puts 'Input number of train here: '
  number = gets.chomp
  case type
  when 1
    train = CargoTrain.new(number)
  when 2
    train = PassengerTrain.new(number)
  end
  train.route = route
  train
end

def add_wagon_to_train(arrays_of_train)
  puts 'Select the train to which one you want to add wagon: '
  arrays_of_train.each do |value|
    puts "Input: #{arrays_of_train.find_index(value)}
 for #{value.number} type: #{value.class}"
  end
  train_position = gets.chomp.to_i
  case arrays_of_train[train_position].class
  when 'CargoTrain'
    arrays_of_train[train_position].add_wagon(Wagon.new(1))
  when 'PassengerTrain'
    arrays_of_train[train_position].add_wagon(Wagon.new(2))
  end
end

def delete_wagon(arrays_of_train)
  puts 'Select the train in which one you want to delete a wagon: '
  arrays_of_train.each do |value|
    puts "Input: #{arrays_of_train.find_index(value)}
 for #{value.number} type: #{value.class}"
  end
  train_position = gets.chomp.to_i
  arrays_of_train[train_position].delete_wagon
end

def add_train_to_station(route, arrays_of_train)
  puts 'Select the station to which one you want to add the train: '
  route.stations.each do |value|
    puts "Input: #{route.stations.find_index(value)}
 for #{value.name}"
  end
  station_position = gets.chomp.to_i
  puts "Select the train which one you want to add to the #{route.stations[station_position].name}:"
  arrays_of_train.each do |value|
    puts "Input: #{arrays_of_train.find_index(value)}
 for #{value.number} type: #{value.class}"
  end
  train_position = gets.chomp.to_i
  route.stations[station_position].get_in_train(arrays_of_train[train_position])
  arrays_of_train[train_position].temporary_station = route.stations[station_position]
end

def user_input(route)
  arrays_of_train = []
  loop do
    list_choice
    choice = gets.chomp
    case choice
    when '1'
      arrays_of_train << create_train(route)
    when '2'
      add_wagon_to_train(arrays_of_train)
    when '3'
      delete_wagon(arrays_of_train)
    when '4'
      add_train_to_station(route, arrays_of_train)
    when '5'
      route.show_stations
    when '0'
      break
    else
      puts 'Sorry, but you missed a bit, try again'
    end
  end
end

station1 = Station.new('Peremoga')
station2 = Station.new('Oleksiivska')
station3 = Station.new('23 Serpnya')
station4 = Station.new('Botanichnyi sad')
station5 = Station.new('Naukova')

route = Route.new(station1, station5)
route.add_station(station2)
route.add_station(station3)
route.add_station(station4)

user_input(route)
