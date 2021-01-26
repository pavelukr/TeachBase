require_relative 'train'
require_relative 'railway_carriage_cargo'

class CargoTrain < Train
  def add_wagon(railway_carriage)
    @railway_carriages << railway_carriage if railway_carriage.instance_of? RailwayCarriageCargo
  end
end
