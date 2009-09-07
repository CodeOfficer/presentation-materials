# a basic example of inheritance

class Vehicle
  # engine behavior
  def start_engine; puts "... vroom vroom"; end
  def stop_engine; puts "... put put"; end
end

class Car < Vehicle
  def travel_somewhere
    puts "A car goes,"
    start_engine
    stop_engine
  end
end

class Bus < Vehicle
  def travel_somewhere
    puts "A bus goes,"
    start_engine
    stop_engine
  end
end

class Bicycle < Vehicle
  def travel_somewhere
    puts "A bicycle goes,"
    puts "... slower while lugging an engine"
  end
end

puts "•inheritance demonstration•"
vehicles = []
vehicles << Car.new
vehicles << Bus.new
vehicles << Bicycle.new
vehicles.each {|v| v.travel_somewhere}
