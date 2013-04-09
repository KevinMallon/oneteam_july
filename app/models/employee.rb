class Employee < ActiveRecord::Base
  attr_accessible :employee_id, :name, :email, :password, :password_confirmation 
  attr_accessible :group, :location, :current_project, :current_skills 
  attr_accessible :skills_interested_in, :department, :supervisor 
  attr_accessible :years_at_company, :description, :job_title
  attr_accessible :skill_ids, :employee_skills_ids, :target_skills_ids
  
  has_many :requests, dependent: :destroy
  has_secure_password
  has_many :responses, dependent: :destroy
  has_many :selections, dependent: :destroy


  has_many :employee_skills, dependent: :destroy
  has_many :target_skills, dependent: :destroy
  has_many :eskills, through: :employee_skills, :source => :skill
  has_many :tskills, through: :target_skills, :source => :skill

  accepts_nested_attributes_for :employee_skills
  accepts_nested_attributes_for :target_skills
  accepts_nested_attributes_for :requests

 
  before_save { |employee| employee.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
 
  def employee_skills_ids
    self.employee_skills.map &:skill_id
  end

  def employee_skills_ids=(employee_skills_ids)
    self.employee_skills = employee_skills_ids.delete_if(&:empty?).map {|id| EmployeeSkill.new({:skill_id => id})}
  end

  def target_skills_ids
    self.target_skills.map &:skill_id
  end

  def target_skills_ids=(target_skills_ids)
    self.target_skills = target_skills_ids.delete_if(&:empty?).map {|id| TargetSkill.new({:skill_id => id})}
  end

private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

