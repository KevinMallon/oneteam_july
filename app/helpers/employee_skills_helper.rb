module EmployeeSkillsHelper

  def skill_names(skill_hash)                                      
	name = Skill.find_by_id(skill_hash.skill_id).name                 
	@skillnames.push(name)         
  end
  
end
