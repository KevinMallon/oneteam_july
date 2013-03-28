module EmployeesHelper
  # Returns the Gravatar (http://gravatar.com/) for the given employee.
  def gravatar_for(employee)
    gravatar_id = Digest::MD5::hexdigest(employee.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: employee.name, class: "gravatar")
  end

def show_skill_and_proficiency(skill_proficiency)               
	if skill_proficiency.level != 0                          
		name = Skill.find_by_id(skill_proficiency.skill_id).name         
		level = skill_proficiency.level         
		@skillname.push(name)         
		@skillname.push(level)       
	end 
end

end
