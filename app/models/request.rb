class Request < ActiveRecord::Base
  attr_accessible :employee_id, :client, :group, :location_id, :project, :created_at, :updated_at
  attr_accessible :content, :skills_needed, :start_date, :stop_date, :active
  attr_accessible :skill_ids, :skills_needed_ids

  belongs_to :employee , dependent: :destroy
  belongs_to :selections

  validates_presence_of :employee_id

  has_many :responses, :dependent => :destroy
  
  has_many :skills, dependent: :destroy, :source => :skill
  has_many :request_skills, dependent: :destroy
  has_many :skills_needed, :through => :request_skills, :source => :skill

  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :request_skills
  
  validate :later_stop_date  

  def later_stop_date    
    if stop_date < start_date           
      errors.add(:end_date,  "End Date must be later than start_date")    
    end  
  end

  def progress_status
    if Date.today >= start_date && stop_date > Date.today
      return "In Progress"
    elsif Date.today < start_date 
      return "Not Started" 
    elsif Date.today > stop_date 
      return "Project completion date has passed" 
    end
  end

  def active_status(request)
    if request.active = "1"
      return "Active"
    else
      return "Cancelled"
    end
  end

  def applied_status(an_employee)
    responses.each do |response| 
      if response.employee == an_employee
        return "applied" 
      end
    end
  return "apply"
  end

  def skills_needed_ids
    self.request_skills.map &:skill_id
  end

  def skills_needed_ids=(skills_needed_ids)
    self.request_skills = skills_needed_ids.delete_if(&:empty?).map {|id| RequestSkill.new({:skill_id => id})}
  end

  def request_max_score(request)   
    request.request_skills.length*4
  end

  def employee_skills_score(employee)
    score = 0       
      skills_needed_ids.each do |sn_id|      
        employee.employee_skills.each do |es|        
          if es.level != 0 && es.skill_id == sn_id          
            score += es.level 
          end        
        end    
      end
    score      
  end

  def target_skills_score(employee)    
    score = 0    
    skills_needed_ids.each do |sn_id|      
      employee.target_skills.each do |ts|        
        if ts.level != 0 && ts.skill_id == sn_id          
          score += ts.level         
        end        
      end    
    end      
    score  
  end


  def proj_length    
    (self.stop_date.to_date - self.start_date.to_date).to_i
  end   

  def view_evaluations(selection)    
    eval_skill = []    
    selection.evaluation.employee_skill_evaluations.each do |skill_evaluation|      
      if skill_evaluation.assigned_skill_level != 0        
        name = skill_evaluation.skill.name         
        eval_skill.push(name)        
        eval_skill.push(skill_evaluation.assigned_skill_level)      
      end    
    end    
    eval_skill.join(", ")  
  end

end

