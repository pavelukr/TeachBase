module Manufacturer
  attr_reader :name

  def name(name)
    self.name = name
  end

  def name
    name
  end

  protected

  attr_writer :name
end
