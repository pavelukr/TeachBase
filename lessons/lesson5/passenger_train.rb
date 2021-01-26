require_relative 'train'
require_relative 'passenger_railway_carriage'

class PassengerTrain < Train
  def add_wagon(railway_carriage)
    railway_carriages << railway_carriage if railway_carriage.instance_of? PassengerRailwayCarriage
  end
end
