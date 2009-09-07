# the context shares data by passing parameters to its strategy

# abstract parent strategy, defines an interface
# doesnt need to be here ... ruby duck types
class Formatter
  def output_report(title, text)
    raise 'abstract method called!'
  end
end

# an html formatting strategy
class HTMLFormatter < Formatter
  def output_report(title, text)
    puts '<html>'
    puts '<head>'
    puts "  <title>#{title}</title>"
    puts '</head>'
    puts '<body>'
    text.each do |line|
      puts "  <p>#{line}</p>"
    end
    puts '</body>'
    puts '</html>'
    puts
  end
end

# a plain text formatting strategy
class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts "**** #{title} ****"
    text.each do |line|
      puts(line)
    end
    puts
  end
end

# the context
class Report
  attr_reader :title, :text
  attr_accessor :formatter
  
  def initialize(formatter)
    @title = 'Monthly Report'
    @text = ["this is a test report", "don\'t get all excited!"]
    # composition
    @formatter = formatter
  end
  
  def output_report
    # delegation with parameters
    @formatter.output_report(@title, @text)
  end
end

# x = context(strategy)
report = Report.new(HTMLFormatter.new)
report.output_report

report = Report.new(PlainTextFormatter.new)
report.output_report









