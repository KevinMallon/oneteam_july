class EmployeeSkill < ActiveRecord::Base
  attr_accessible :employee_id, :skill_id, :proficiency
  belongs_to :employee
  belongs_to :skill
end

