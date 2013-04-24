class Employee < ActiveRecord::Base
  attr_accessible :employee_id, :name, :email, :password, :password_confirmation 
  attr_accessible :group, :location, :current_project, :current_skills 
  attr_accessible :skills_interested_in, :department, :supervisor 
  attr_accessible :years_at_company, :description, :job_title
  attr_accessible :skill_ids, :employee_skills_data, :target_skills_data


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

  def has_skill_level(skill_id, level)          
    employee_skills.each do |emp_id|       
      return true  if emp_id.skill_id == skill_id && emp_id.level == level                   
    end              
    level == 0
  end  

  def target_skill_level(skill_id, level)   
  target_skills.each do |dev_id|       
    return true  if dev_id.skill_id == skill_id && dev_id.level == level          
    end              
    level == 0    
  end 





 
  def employee_skills_data
    self.employee_skills.map &:skill_id
  end

  def employee_skills_data=(employee_skills_data)
    self.employee_skills = to_employee_skills employee_skills_data
  end


  def target_skills_data
    self.target_skills.map &:skill_id
  end

  def target_skills_data=(target_skills_data)
    self.target_skills = to_target_skills target_skills_data 
  end







def to_employee_skills(employee_skills_data)    
  if !employee_skills_data.nil?  
    employee_skills = []  
    employee_skills_data.each do |skill, level|            
      employee_skills.push(EmployeeSkill.new( :skill_id => skill, :level => level))      
    end  
    employee_skills  
    end
  end

def to_target_skills(target_skills_data)    
  if !target_skills_data.nil?  
    target_skills = []  
    target_skills_data.each do |skill, level|        
      target_skills.push(TargetSkill.new( :skill_id => skill, :level => level))      
    end  
    target_skills  
    end
  end




private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

