class RequestSkill < ActiveRecord::Base
  attr_accessible :employee_id, :skill_id
  belongs_to :request
  belongs_to :skill
end
