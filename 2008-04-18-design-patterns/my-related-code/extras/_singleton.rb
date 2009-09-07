=begin rdoc
  using .... include Singleton makes
  Klass.new and Klass.allocate - as private
  clone and dup - raising TypeErrors to prevent cloning or duping
Instance methods:
-----------------
     _dump, clone, dup

=end


# not thread safe
# someone can still call OnlyMe.new manually

class OnlyMe

  @@the_instance = nil

  def OnlyMe.instance
    if not @@the_instance
      @@the_instance = OnlyMe.new
    end
    @@the_instance
  end

  # Other methods...

end

puts "\nOnlyMe::instance <LEGIT>"
o = OnlyMe::instance
puts o
o = OnlyMe::instance
puts o

puts "\nOnlyMe.new <BAD BAD>"
o = OnlyMe.new
puts o
o = OnlyMe.new
puts o

puts "\n•injecting our singleton behavior•"
require 'singleton'
class OnlyMe
  include Singleton
end

puts "\nOnlyMe::instance <STILL LEGIT>"
o = OnlyMe::instance
puts o
o = OnlyMe::instance
puts o

puts "\nOnlyMe.new <BOOM>"
o = OnlyMe.new
puts o