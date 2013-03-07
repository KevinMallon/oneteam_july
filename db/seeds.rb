

["PHP", "MySQL", "C#", "Ruby on Rails", "Ruby on Rails", "SQL Server", "Linux"].each do |skill|
Skills.find_or_create_by_name(skill)
end