class EmployeeLocation < ActiveRecord::Base
  attr_accessible :employee_id, :location_id
  belongs_to :employee
  belongs_to :location
end
