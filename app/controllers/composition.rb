class EmployeeTaxData
  def initialize(employee, ssn, salary)
    @employee = employee
    @ssn = ssn
    @salary = salary
  end

  # ...
end

class Employee
  def initialize(name, email)
    @name = name
    @email = email
  end

  def set_tax_data(ssn, salary)
    @tax_data = EmployeeTaxData.new(employee, ssn, salary)
  end
  # ...
end