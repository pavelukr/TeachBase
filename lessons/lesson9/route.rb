class Route
  attr_accessor :stations,
                :counter

  def initialize(begin_of_route = '', end_of_route = '')
    @stations = [begin_of_route, end_of_route]
    @counter = 1
  end

  def add_station(station)
    @stations.insert(counter, station)
    @counter += 1
  end

  def delete_station(station)
    @stations.delete(station)
    @counter -= 1
  end

end
