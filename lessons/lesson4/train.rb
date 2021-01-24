class Train

  attr_accessor :speed,
                :temporary_station,
                :route,
                :wagons
  attr_reader :number

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def train_stop
    @speed = 0
  end

  def delete_wagon
    if (wagons.length - 1) >= 0
      wagons.delete_at(wagons.length - 1) unless speed.zero?
    end
  end

  def add_wagon; end

  def showing_route
    puts "The previous station is #{
      if @route.stations.find_index(temporary_station) != 0
        @route.stations[route.stations.find_index(temporary_station) - 1].name
      end}\n
The temporary station is #{temporary_station.name}\n
The next station is #{
      if @route.stations.find_index(temporary_station) != (@route.stations.length - 1)
        @route.stations[@route.stations.find_index(temporary_station) + 1].name
      end}"
  end
end
