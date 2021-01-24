require_relative 'train'

class PassengerTrain < Train
  def add_wagon(wagon)
    wagons << wagon if wagon.type == 2
  end
end
