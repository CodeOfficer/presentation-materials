# example provided by Josh Goebel (defunkt) on irc.freenode.net
# number 58 in the who's who list of the working wth rails website
# creator of Pastie and Beast (co-written with Russ Olsen, author of DPR)
# woot!

class Characters
  attr_accessor :value
  
  def self.matcher(regexp = nil)
    @matcher ||= regexp
  end
  
  def self.inherited(subclass)
    (@subclasses ||= []) << subclass
  end

  class << self; alias_method :real_new, :new end  
  
  def self.new(*a, &b)
    if match = @subclasses.detect { |klass| klass.matcher =~ a.first }
      match.real_new(*a, &b)
    end
  end
  
  def initialize(*a, &b)
    @value = a[0]
  end
end

class Letters < Characters
  matcher /^[A-Za-z]+$/  
end

class Numbers < Characters
  matcher /^[0-9]+$/ 
end

class Others < Characters
  matcher /.+/
end

factory_results = []
%w{12345 1o1 ruby 8675309 ••• whatever OU812 ^%$#^%$}.each { |x| factory_results << Characters.new(x) }
factory_results.sort! { |x,y| y.class.to_s <=> x.class.to_s }.reverse!
factory_results.each { |obj| puts "#{obj.class}: #{obj.value}" }
