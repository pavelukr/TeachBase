require_relative 'train'

class PassengerTrain < Train
  def add_wagon(railway_carriage)
    railway_carriages << railway_carriage if railway_carriage.type == 2
  end
end
