class Employee < ActiveRecord::Base
  attr_accessible :employee_id, :name, :email, :password, :password_confirmation 
  attr_accessible :group, :location_id, :current_project, :current_skills 
  attr_accessible :skills_interested_in, :department, :supervisor 
  attr_accessible :years_at_company, :description, :job_title
  attr_accessible :skill_ids, :employee_skills_data, :target_skills_data

  has_one :employee_location, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_secure_password
  has_many :responses, dependent: :destroy
  has_many :selections, dependent: :destroy

  has_many :employee_skills, dependent: :destroy
  has_many :target_skills, dependent: :destroy

  accepts_nested_attributes_for :employee_skills
  accepts_nested_attributes_for :target_skills
  accepts_nested_attributes_for :requests
  accepts_nested_attributes_for :employee_location
 
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

  def skill_experience_sum(skill_id)
    skill_experience_sum = 0
    if !self.responses.nil? 
      EmployeeSkillEvaluation.all.each do |skill_eval|
        if !skill_eval.evaluation.nil?       
          if skill_eval.evaluation.response.employee_id == self.id && skill_eval.skill_id == skill_id        
            skill_experience_sum += skill_eval.skill_experience_points
          end
        end    
      end
    skill_experience_sum
    end     
  end

  def average_skill_level(skill_id)    # charity example
    eval_counter = 0    
    sum = 0    
    if !self.responses.nil?      
      self.responses.each do |response|        
      if response.employee_id == self.id && !response.evaluation.nil?            
        response.evaluation.employee_skill_evaluations.each do |es_eval|
          if es_eval.skill_id == skill_id && es_eval.assigned_skill_level != 0              
            sum += es_eval.assigned_skill_level              
            eval_counter += 1 
          end                    
        end  
      end             
    end      
      if eval_counter == 0         
        "n/a"      
      else        
        sum/eval_counter.to_f      
      end    
    end    
  end

  def view_evaluations(response)    
    eval_skill = []    
    response.evaluation.employee_skill_evaluations.each do |skill_evaluation|      
      if skill_evaluation.assigned_skill_level != 0        
        name = skill_evaluation.skill.name         
        eval_skill.push(name)        
        eval_skill.push(skill_evaluation.assigned_skill_level)      
      end    
    end    
    eval_skill.join(", ")  
  end

  def view_my_ratings    
    my_level = []    
    self.employee_skills.each do |emp_skill|              
        name = emp_skill.skill.name         
        my_level.push(name)        
        my_level.push(emp_skill.level)      
    end    
    my_level.join(", ")  
  end

  def skill_level(request, skill_id)    
    request.responses.each do |response|      
      if response.employee_id == self.id && !response.evaluation.nil?        
        response.evaluations.employee_skill_evaluation.each do |sk_eval|          
          if sk_eval.skill_id == skill_id            
            return sk_eval.assigned_skill_level          
          end        
        end      
      else         
        return 0      
      end    
    end  
  end
  

private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end

