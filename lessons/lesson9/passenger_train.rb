require_relative 'train'
require_relative 'passenger_railway_carriage'

class PassengerTrain < Train
  def add_wagon(railway_carriage)
    if railway_carriage.instance_of? PassengerRailwayCarriage
      railway_carriages << railway_carriage
    else
      puts 'Wrong type of carriage, this is passenger train,
so only passengers carriages can be added to this on, try again'
    end
  end
end
