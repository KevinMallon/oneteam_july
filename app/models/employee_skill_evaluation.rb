class EmployeeSkillEvaluation < ActiveRecord::Base  
attr_accessible :assigned_skill_level, :evaluation_id, :skill_experience_points, :skill_id    

belongs_to :evaluation  
belongs_to :skill

end