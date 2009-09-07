# a basic example of composition


# engine behavior encapsulated into its own class
class Engine
  def start; puts "... vroom vroom"; end
  def stop; puts "... put put"; end
end

class Vehicle
  def travel_somewhere
    raise 'abstract method called!'
  end
end

class Car < Vehicle
  def initialize
    @engine = Engine.new
  end
  def travel_somewhere
    puts "A car goes,"
    @engine.start
    @engine.stop
  end
end

class Bus < Vehicle
  def initialize
    @engine = Engine.new
  end
  def travel_somewhere
    puts "A bus goes,"
    @engine.start
    @engine.stop
  end
end

class Bicycle < Vehicle
  def travel_somewhere
    puts "A bicycle goes,"
    puts "... faster without lugging an engine"
  end
end

puts "•composition demonstration•"
vehicles = []
vehicles << Car.new
vehicles << Bus.new
vehicles << Bicycle.new
vehicles.each {|v| v.travel_somewhere}
