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

class Employee
  attr_reader :name
  attr_reader :salary
  def initialize(name, salary)
    @name = name
    @salary = salary
    @observers = []
  end
  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
  def add_observer(observer)
    @observers << observer
  end
  def delete_observer(observer)
    @observers.delete(observer)
  end
end

payroll = Payroll.new
taxman = Taxman.new
employee = Employee.new('Russ', 3000.00)
  employee.add_observer(payroll)
  employee.add_observer(taxman)
employee.salary = "50 Million"