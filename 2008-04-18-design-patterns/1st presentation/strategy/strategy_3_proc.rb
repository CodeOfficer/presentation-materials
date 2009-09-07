# strategy is passed in to the context as a block

# an html formatting strategy as a proc
HTML_FORMATTER = lambda do |context|
  puts '<html>'
  puts '<head>'
  puts "  <title>#{context.title}</title>"
  puts '</head>'
  puts '<body>'
  context.text.each do |line|
    puts "  <p>#{line}</p>"
  end
  puts '</body>'
  puts '</html>'
  puts
end

# a plain text formatting strategy as a proc
PLAINTEXT_FORMATTER = lambda do |context|
  puts "**** #{context.title} ****"
  context.text.each do |line|
    puts(line)
  end
  puts
end

# the context
class Report
  attr_reader :title, :text
  attr_accessor :formatter
  
  def initialize(&formatter)
    @title = 'Monthly Report'
    @text = ["this is a test report", "don\'t get all excited!"]
    # composition
    @formatter = formatter
  end
  
  def output_report
    # delegation
    @formatter.call(self)
  end
end

report = Report.new(&HTML_FORMATTER)
report.output_report

report = Report.new(&PLAINTEXT_FORMATTER)
report.output_report

report = Report.new do |context|
  puts "•••• #{context.title} ••••"
  context.text.each do |line|
    puts(line)
  end
end
report.output_report








