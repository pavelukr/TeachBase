class Station

  attr_reader :name

  attr_accessor :list_of_trains

  def initialize(name)
    @name = name
    @list_of_trains = []
  end

  def get_in_train(train)
    have_or_not = true
    list_of_trains.each do |value|
      have_or_not = false if value.number == train.number
    end
    if have_or_not
      @list_of_trains << train
    else
      puts "You can't add the same train to station twice"
    end
  end

  def show_all_trains
    puts 'These trains are on the station now: '
    list_of_trains.each { |train| print " #{train.number}; " }
    puts "\n"
  end

  def setting_up_train(train)
    puts "Setting up the train #{train.number}"
    list_of_trains.delete(train)
  end

  def count_type(cargo, passenger)
    list_of_trains.each do |train|
      case train.class
      when 'CargoTrain'
        cargo += 1
      when 'PassengerTrain'
        passenger += 1
      else
        puts 'Something went wrong'
      end
    end
  end

  def count_trains
    cargo = 0
    passenger = 0
    count_type(cargo, passenger)
    puts "On the station you have #{cargo} type cargo of wagons and #{passenger} type passenger of wagons"
  end
end