require_relative 'train'

class CargoTrain < Train
  def add_wagon(wagon)
    @wagons << wagon if wagon.type == 1
  end
end
