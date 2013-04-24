class EmployeeSkillEvaluation < ActiveRecord::Base
  attr_accessible :assessed_proficiency, :experience_points, :response_id, :skill_id

  belongs_to :response
  belongs_to :skill
end
