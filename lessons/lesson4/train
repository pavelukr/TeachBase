class Train

  attr_accessor :speed,
                :temporary_station,
                :route
  attr_reader :number,
              :wagons

  def initialize(number)
    @number = number
    @wagons = []
  end

  def train_stop
    @speed = 0
  end

  def delete_wagon(wagon)
    unless speed.zero?
      wagons.delete(wagon)
    end
  end

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

  protected

  attr_writer :number,
              :wagons
end
