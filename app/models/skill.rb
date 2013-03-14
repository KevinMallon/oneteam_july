class Skill < ActiveRecord::Base
  attr_accessible :name

  has_many :employee_skills, dependent: :destroy
  has_many :employees, through: :employee_skills

  has_many :skills_needed, dependent: :destroy
  has_many :requests, through: :request_skills

  has_many :target_skills, dependent: :destroy
  has_many :users, through: :target_skills

end
