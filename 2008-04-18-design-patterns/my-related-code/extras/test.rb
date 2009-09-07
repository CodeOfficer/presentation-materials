name = "Russ"

w = Proc.new { |x| puts name*x }
x = lambda { return name }
y = lambda do 
      return name 
    end
z = Proc.new { |x,y| name*(x*y) }

puts x
puts x.call

puts y
puts y.call

puts z
puts z.call(2,2)

def run_it(&block)
  puts
  puts 'before the yield'
  block.call(10)
  puts 'after the yield'
  puts
end

run_it { |x| puts "#{x} HERE I AM!" }

my_proc = lambda {|x| puts "the value of x: #{x}" }

run_it(&w)

run_it(&my_proc)