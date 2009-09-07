# a factory outside the inheritance tree
# an abstract parent shares behavior across its children

class CharactersFactory
  def CharactersFactory.new(*a, &b)
    klass = 
      case a[0]
        when /^[A-Za-z]+$/
          Letters
        when /^[0-9]+$/
          Numbers
        else
          Others
      end
    return klass.send(:new, *a, &b)
  end
end

class Characters
  private_class_method :new 
  attr_accessor :value
  
  def initialize(*a, &b)
    @value = a[0]
  end
end

class Letters < Characters; end
class Numbers < Characters; end
class Others < Characters; end

factory_results = []
%w{12345 1o1 ruby 8675309 ••• whatever OU812 ^%$#^%$}.each { |x| factory_results << CharactersFactory.new(x) }
factory_results.sort! { |x,y| y.class.to_s <=> x.class.to_s }.reverse!
factory_results.each { |obj| puts "#{obj.class}: #{obj.value}" }