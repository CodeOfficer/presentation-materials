# the context shares data by passing self to its strategy

# abstract parent strategy, defines an interface
# doesnt need to be here ... ruby duck types
class Formatter
  def output_report(context)
    raise 'abstract method called!'
  end
end

# an html formatting strategy
class HTMLFormatter < Formatter
  def output_report(context)
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
end

# a plain text formatting strategy
class PlainTextFormatter < Formatter
  def output_report(context)
    puts "**** #{context.title} ****"
    context.text.each do |line|
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
    # delegation
    @formatter.output_report(self)
  end
end

report = Report.new(HTMLFormatter.new)
report.output_report

report = Report.new(PlainTextFormatter.new)
report.output_report









