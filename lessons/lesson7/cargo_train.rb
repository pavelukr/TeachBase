require_relative 'train'
require_relative 'railway_carriage_cargo'

class CargoTrain < Train
  def add_wagon(railway_carriage)
    if railway_carriage.instance_of? RailwayCarriageCargo
      @railway_carriages << railway_carriage
    else
      puts 'Wrong type of carriage, this is cargo train,
so only cargo carriages can be added to this on, try again'
    end
  end
end
