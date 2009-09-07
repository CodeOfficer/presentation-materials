# a really simple example of a strategy pattern

a = ['russell','mike','george','whatever','qwqeqweqweewq']

puts a.sort.join(', ')

# and with a strategy
puts a.sort { |a,b| a.length <=> b.length }
