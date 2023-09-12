# Remove duplicate code

def show_employee_list(employees)
  employees.each do |employee|
    data = build_data(employee)
    render(data)
  end
end

def build_data(employee)
  general_data = {
    expected_salary: employee.expected_salary,
    experience: employee.experience
  }

  general_data.merge(position_specific_data(employee))
end

def position_specific_data(employee)
  case employee.type
  when 'manager'
    { portfolio: employee.mba_projects }
  when 'developer'
    { github_link: employee.github_link }
  end
end