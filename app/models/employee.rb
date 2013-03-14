# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Employee < ActiveRecord::Base
  attr_accessible :employee_id, :name, :email, :password, :password_confirmation 
  attr_accessible :group, :location, :current_project, :current_skills 
  attr_accessible :skills_interested_in, :department, :supervisor 
  attr_accessible :years_at_company, :description, :job_title
  attr_accessible :employee_skills_ids

  has_many :requests, dependent: :destroy
  has_secure_password
  has_many :responses, dependent: :destroy

  has_many :employee_skills, dependent: :destroy
  has_many :target_skills, dependent: :destroy
  has_many :skills, :through => :employee_skills, :source => :skill
  has_many :skills, :through => :target_skills, :source => :skill
  has_many :skills, :through => :request_skills, :source => :skill

  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :employee_skills
  accepts_nested_attributes_for :target_skills
 
  before_save { |employee| employee.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

def employee_skills_ids
  [employee_skills].join(",")   #getter
end

def employee_skills_ids=(employee_skills)
  split = self.employee_skills.split(",")     #setter
  self.employee_skills
end 

def target_skills_ids
  [target_skills_ids].join(",")   #getter
end


def current_skills_levels
   #getter
end

def current_skills_levels=(skills_hash)
       #setter
end 

def target_skills_levels
   #getter
end

def target_skills_levels=(skills_hash)
       #setter
end 


