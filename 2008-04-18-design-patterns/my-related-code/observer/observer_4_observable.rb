class Payroll
  def update(changed_employee)
    puts "Payroll says: Salary for #{changed_employee.name} is now: #{changed_employee.salary}"
  end
end

class Taxman
  def update(changed_employee)
    puts "Taxman says: Send #{changed_employee.name} a new Tax bill!"
  end
end

require 'observer'
class Employee
  include Observable
  attr_reader :name
  attr_reader :salary
  def initialize(name, salary)
    super()
    @name = name
    @salary = salary
  end
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

payroll = Payroll.new
taxman = Taxman.new

employee = Employee.new('Russ', 3000.00)
  employee.add_observer(payroll)
  employee.add_observer(taxman)
employee.salary = "50 Million"