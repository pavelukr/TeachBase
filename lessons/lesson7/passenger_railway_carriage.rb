class PassengerRailwayCarriage
  attr_reader :number_of_taken_seats

  def initialize(number_of_seats)
    self.number_of_seats = number_of_seats
    self.number_of_taken_seats = 0
  end

  def take_seat
    self.number_of_taken_seats += 1
  end

  def free_seats
    number_of_seats - number_of_taken_seats
  end

  protected

  attr_accessor :number_of_seats

  attr_writer :number_of_taken_seats
end
