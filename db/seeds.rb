["PHP", "MySQL", "C#", "Ruby on Rails", "Ruby on Rails", "SQL Server", "Linux"].each do |skill|
Skill.find_or_create_by_name(skill)
end

["Chicago", "Boston", "Houston", "San Francisco", "London", "Mumbai"].each do |loc|
Location.find_or_create_by_location_name(loc)
end

