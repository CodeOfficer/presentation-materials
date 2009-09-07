# we want to generate different types of reports
# we need a Report object with its template method
# and its subclasses, HTMLReport and PlainTextReport

class Report
  def initialize
    @title = 'Monthly Report'
    @text = ["this is a test report", "don\'t get all excited!"]
  end
  # the template method
  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end
  def output_body
    @text.each { |line| output_line(line) }
  end
  # hook methods, needn't be used
  def output_start; end;
  def output_body_start; end;
  def output_body_end; end;
  def output_end; end;
  # must be overridden in the subclass
  def output_head; raise 'output_head'; end;
  def output_line(line); raise 'output_line'; end;
end


class HTMLReport < Report
  # doesnt override output_report
  def output_start
    puts '<html>'
  end
  def output_head
    puts '<head>'
    puts "  <title>#{@title}</title>"
    puts '</head>'
  end
  def output_body_start
    puts '<body>'
  end
  def output_line(line)
    puts "  <p>#{line}</p>"
  end
  def output_body_end
    puts '</body>'
  end
  def output_end
    puts '</html>'
    puts
  end
end


class PlainTextReport < Report
  # doesnt override output_report
  def output_head
    puts "**** #{@title} ****"
  end
  def output_line(line)
    puts(line)
  end
  def output_end
    puts
  end
end

# x = template
report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report




