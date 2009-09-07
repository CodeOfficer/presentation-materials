# the ruby-er way ... using mixins
# this version uses a ruby module instead of staight inheritance to share behaviors across classes
# it also retains its ability to track its child classes

module CharactersMixin
  module ClassMethods; end
  
  module InstanceMethods 
    def initialize(*a, &b)
      @value = a[0]
    end
  end

  class << self; attr_reader :classes; end
  
  def self.included(receiver)
    @classes ||= []
    @classes << receiver
    receiver.send :private_class_method,   :new 
    receiver.send :attr_accessor,          :value
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

class Letters; include CharactersMixin; end
class Numbers; include CharactersMixin; end
class Others; include CharactersMixin; end

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

factory_results = []
%w{12345 1o1 ruby 8675309 ••• whatever OU812 ^%$#^%$}.each { |x| factory_results << CharactersFactory.new(x) }
factory_results.sort! { |x,y| y.class.to_s <=> x.class.to_s }.reverse!
factory_results.each { |obj| puts "#{obj.class}: #{obj.value}" }
puts ''
CharactersMixin.classes.each { |x| puts "#{x}" }

