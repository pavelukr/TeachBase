class RailwayCarriageCargo
  attr_reader :occupied_volume

  def initialize(overall_volume)
    self.overall_volume = overall_volume
    self.occupied_volume = 0.0
    self.occupied_volume = 0.0
  end

  def to_occupy_volume(occupied_volume)
    self.occupied_volume = occupied_volume
  end

  def left_volume
    overall_volume - occupied_volume
  end

  protected

  attr_accessor :overall_volume

  attr_writer :occupied_volume
end
