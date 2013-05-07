class Evaluation < ActiveRecord::Base
  attr_accessible :response_id, :evaluated_skills,   
  :evaluated_skill_ids, :skills_experience, :skill_experience_ids

  belongs_to :response
  has_many :employee_skill_evaluations

  accepts_nested_attributes_for :employee_skill_evaluations

  def existing_skill_level?(skill_id, level)
    if response.evaluation.nil?
      response.employee.employee_skills.each do |es|      
      return true if es.skill_id == skill_id && es.level == level
      end    
    else  
      self.employee_skill_evaluations.each do |es|      
      return true if es.skill_id == skill_id && es.assigned_skill_level == level    
    end
  end     
  level == 0  
  end   

  def evaluated_skill_ids    
    self.evaluated_skills.map {|es| es.id}  
  end  

  def evaluated_skills= (skill_info)    
    self.employee_skill_evaluations =     
    make_evaluated_skill_array(skill_info)  
  end    

  def make_evaluated_skill_array(skill_info) 
    skill_evaluations = []    
    skill_info[0].each do |key, info_hash|      
      skill_id = key      
      level = info_hash["level"]      
      experience = info_hash["skill_experience"]      
      skill_evaluations << EmployeeSkillEvaluation.new(:skill_id => skill_id, :assigned_skill_level =>        
        level, :skill_experience_points => experience)    
    end    
    skill_evaluations  
  end   

  def skill_experience_ids    
    self.skills_experience.map {|se| se.id}  
  end  

  def skills_experience= (ids_with_experience_points)    
    self.employee_skill_evaluations =     
    make_skill_experience_array(ids_with_experience_points)  
  end  

  def make_skill_experience_array(ids_with_experience_points)    
    ids_with_experience_points.map {|skill_id, experience_points|       
      EmployeeSkillEvaluation.create(:skill_id => skill_id,:skill_experience_points => experience_points)}  
  end 

  def previous_experience_points(skill_id) 
    self.employee_skill_evaluations.each do |es|
      if es.skill_id == skill_id
        return es.skill_experience_points
      end
    end
  end   

end
