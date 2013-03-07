class Skill < ActiveRecord::Base
  attr_accessible :name, :skill_id
  has_many :employees, :through => :employee_skills
  has_many :requests, :through => :request_skills
end
