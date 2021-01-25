require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed,
                :temporary_station,
                :route,
                :railway_carriages
  attr_reader :number

  def initialize(number)
    @number = number
    @railway_carriages = []
    @speed = 0
    register_instance
  end

  def train_stop
    @speed = 0
  end

  def delete_wagon
    railway_carriages.delete_at(railway_carriages.length - 1) if (railway_carriages.length - 1) >= 0 && !speed.zero?
  end

  def add_wagon; end

  def show_previous_station
    puts "The previous station is #{
      if @route.stations.find_index(temporary_station) != 0
        @route.stations[route.stations.find_index(temporary_station) - 1].name
      end}"
  end

  def show_next_station
    puts "The next station is #{
      if @route.stations.find_index(temporary_station) != (@route.stations.length - 1)
        @route.stations[@route.stations.find_index(temporary_station) + 1].name
      end}"
  end

  def showing_route
    show_previous_station
    puts "The temporary station is #{temporary_station.name}"
    show_next_station
  end

  def find(number)
    train = nil
    ObjectSpace
      .each_object(Train)
      .each { |value| train = value if value.number == number }
    train
  end
end
