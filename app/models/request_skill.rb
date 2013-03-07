class RequestSkill < ActiveRecord::Base
  attr_accessible :employee_id, :skill_id, :skills_needed
  belongs_to :request
  belongs_to :skill
end
