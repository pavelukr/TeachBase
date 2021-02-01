require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /([a-z]{3}|\d{3})-?([a-z]{2}|\d{2})/i.freeze

  attr_accessor :speed,
                :temporary_station,
                :route,
                :railway_carriages
  attr_reader :number

  validate :number, :format, NUMBER_FORMAT
  validate :number, :presence

  def initialize(number)
    @number = number
    @railway_carriages = []
    @speed = 0
    validate!
    register_instance
  end

  def train_stop
    @speed = 0
  end

  def delete_wagon
    if (railway_carriages.length - 1) >= 0 && !speed.zero?
      railway_carriages.delete_at(railway_carriages.length - 1)
    else
      puts "You can't delete a railway carriage cause your train doesn't have one"
    end
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

  def add_route(route)
    self.route = route if route.instance_of?(Route)
  end

  def find(number)
    train = nil
    ObjectSpace
      .each_object(Train)
      .each { |value| train = value if value.number == number }
    train
  end

  def show_carriage_info(&block)
    railway_carriages.each do |carriage|
      block.call(carriage)
    end
  end
end
