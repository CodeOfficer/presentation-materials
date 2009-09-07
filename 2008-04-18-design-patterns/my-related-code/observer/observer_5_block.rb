class Payroll
  def update(changed_employee)
    puts "Payroll says: Salary for #{changed_employee.name} is now: #{changed_employee.salary}"
  end
end

module Subject
  def initialize
    @observers = []
  end
  def add_observer(arg=nil, &observer)
    observer = arg || observer
    @observers << observer
  end
  def delete_observer(observer)
    @observers.delete(observer)
  end
  def notify_observers
    @observers.each do |observer|
      if observer.is_a? Proc
        observer.call(self)
      else
        observer.update(self)
      end
    end
  end
end

class Employee
  include Subject
  attr_reader :name
  attr_reader :salary
  def initialize(name, salary)
    super()
    @name = name
    @salary = salary
  end
  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

payroll = Payroll.new
employee = Employee.new('Russ', 3000.00)
  employee.add_observer(payroll)
  employee.add_observer do |changed_employee|
    puts "OMG: #{changed_employee.name} makes: #{changed_employee.salary}"
  end
employee.salary = "50 Million"

