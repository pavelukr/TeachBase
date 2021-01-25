require_relative 'train'

class CargoTrain < Train
  def add_wagon(railway_carriage)
    @railway_carriages << railway_carriage if railway_carriage.type == 1
  end
end
