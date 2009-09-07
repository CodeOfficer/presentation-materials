class Payroll
  def update(changed_employee)
    puts "Payroll says: Salary for #{changed_employee.name} is now: #{changed_employee.salary}"
  end
end

class Employee
  attr_reader :name
  attr_reader :salary
  def initialize(name, salary, payroll)
    @name = name
    @salary = salary
    @payroll = payroll
  end
  def salary=(new_salary)
    @salary = new_salary
    @payroll.update(self)
  end
end

payroll = Payroll.new
employee = Employee.new('Russ', 3000.00, payroll)
employee.salary = "50 million"
