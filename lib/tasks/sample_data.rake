namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    @job_titles = ["Engineer", "Analyst", "Project Lead", "UI Specialist", "QA Specialist"]    
    @departments = ["IT", "Marketing", "Analytics", "Research"]    
    @groups = ["Development", "Interface Design","QA","Infrastructure"]    
    @locations = ["Chicago",  "Mumbai", "Houston", "San Francisco", "Boston", "London"]
    @locations_and_ids = {"Chicago"=>1, "Boston"=>2, "Houston"=>3, "San Francisco"=>4, "London"=>5,       
      "Mumbai"=>6} 
    location_ids_with_num_employees = { 1 => 45, 2 => 20, 3 => 32, 
    4 => 14, 5 => 12, 6 => 5}
    skill_ids = [1,2,3,4,5,6]

    def pick_eskills
      skill_ids = [1,2,3,4,5,6]
      @eskillpicks = skill_ids.sample(rand(1..6))
      @eskillpicks
    end

    def pick_tskills
      skill_ids = [1,2,3,4,5,6]
      @tskillpicks = skill_ids.sample(rand(1..6))
      @tskillpicks
    end

    def create_employee (n, location_id)
      name  = Faker::Name.name
      email = Faker::Internet.email
      password  = "password"

      Employee.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password,  
                    group: ["Development", "Interface Design", "QA", "Infrastructure"].sample.to_s,
                    location_id: location_id,
                    department: ["IT", "Marketing", "Analytics", "Research"].sample.to_s,
                    supervisor: Faker::Name.name,
                    years_at_company: rand(1..20),
                    job_title: ["Engineer", "Analyst", "Project Lead", "UI Specialist", "QA Specialist"].sample.to_s,
                    description: Faker::Lorem.paragraph(sentence_count = 2) )
      pick_eskills
      @eskillpicks.length.times do |n|       
        EmployeeSkill.create(employee_id: Employee.last.id,                                  
          skill_id: @eskillpicks[n],                                  
          level: rand(1..4))
      end        
      pick_tskills
      @tskillpicks.length.times do |n|  
        TargetSkill.create(employee_id: Employee.last.id,                                  
          skill_id: @tskillpicks[n],                                  
          level: rand(1..4))
      end
    end      

    def create_selection (response_id)
      Selection.create!(      
          comments: Faker::Lorem.sentences(1),      
          request_id: Response.find_by_id(response_id).request_id,             
          response_id: response_id,      
          employee_id: Response.find_by_id(response_id).employee_id,      
          created_at: res_selection_date(Response.find_by_id(response_id).created_at),
          updated_at: res_selection_date(Response.find_by_id(response_id).created_at))    
    end 

    def location_employee_ids (location_id)      
      Employee.find_all_by_location_id(location_id).map(&:id)    
    end     

    def location_request_ids (location_id)      
      Request.find_all_by_location_id(location_id).map(&:id)    
    end      

    def all_employee_ids      
      Employee.all.map(&:id)    
    end     

    def all_response_ids      
      Response.all.map(&:id)    
    end      

    def selected_response_ids 
      selected_response_ids = Selection.all.map(&:response_id)
    end

    def unselected_response_ids      
      unselected_response_ids = all_response_ids - selected_response_ids
      unselected_response_ids.shuffle    
    end  

    def ids_for_requests_with_responses      
      Response.all.map(&:request_id).uniq.shuffle     
    end         

    def available_request_ids      
      available_request_ids = []      
      [1..5].each do |loc_id|        
        available_request_ids.concat(location_request_ids(loc_id))      
      end      
      available_request_ids    
    end      

    def ids_for_requests_with_selections      
      selected_response_ids = Selection.all.map(&:response_id)      
      selected_response_ids.map{|res_id|         
        Response.find(res_id).request_id}.uniq    
      end     

    def unselected_request_ids      
      ids_for_requests_with_responses - ids_for_requests_with_selections    
    end       

#create employees
    location_ids_with_num_employees.each do |loc_id, num_employees|      
      emp_ids_array = []      
      num_employees.times do |n|         
        create_employee(n, loc_id)        
        employee_id = Employee.last.id             
      end      
    end

#create around 120 project request posts over 6 or more months 

    def get_start_date    
      Array((Date.today - 6.months)..(Date.today)).sample  
    end
      
    locid_numreqs = {1 => [12, 1, 3, 7, 5, 5, 4, 8], 2 => [14, 1, 8, 2, 9, 6], 4 => [9, 1, 3], 5 => [4, 8], 6 => [8, 2]}

    locid_numreqs.each do |locid, number_of_reqs_array|   
      loc_emp_ids =  Employee.find_all_by_location_id(locid).map &:id 
      emp_ids = loc_emp_ids.sample(number_of_reqs_array.size)
      emp_ids_with_num_requests = Hash[emp_ids.zip(number_of_reqs_array)]

      emp_ids_with_num_requests.each do |emp_id, number_of_reqs|
        number_of_reqs.times do
          Request.create!(
                employee_id: emp_id,  
                group: @groups.sample.to_s,
                location_id: locid,
                start_date: start_date = get_start_date,                        
                stop_date: start_date + rand(1..90).days,                           
                content: Faker::Lorem.sentences(2).join(" "),
                project: Faker::Lorem.words(2).join(" ").to_s.capitalize,
                created_at: created_at = start_date - rand(1..30).days,
                updated_at: created_at,
                active: active = 1 )      
        end      
      end                                                       
    end

    def random_resp_date(request_date)      
      [(request_date + 1.day), (request_date += 2.days), (request_date += 4.days), (request_date += 8.days)].sample    
    end   

 # All requests from London received at least 3 responses

    london_req_ids = location_request_ids(5)
    emp_ids_for_london_responses = all_employee_ids.sample(36)

    london_req_ids.each do |request_id|    
        3.times do
            Response.create!(
                  request_id: request_id,
                  response: Faker::Lorem.sentences(1),
                  employee_id: emp_ids_for_london_responses.pop, #pop used to avoid same emp responding 2x to same req
                  created_at: random_resp_date(Request.find_by_id(request_id).start_date),
                  updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
        end 
    end

    resp_employee_id = all_employee_ids.sample(23)
    23.times do        
      Response.create!(
              request_id: request_id = available_request_ids.sample,
              response: Faker::Lorem.sentences(1),
              employee_id: resp_employee_id.sample,
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
    end     

#o 2 responses were personal, i.e., a developer responded to their own request
    def ids_for_requests_with_no_responses   
      Request.all.map(&:id) - ids_for_requests_with_responses    
    end 

    own_request_ids = ids_for_requests_with_no_responses.sample(2).to_a

    own_request_ids.each do |request_id|      
      Response.create!(
              request_id: request_id,
              response: Faker::Lorem.sentences(1),
              employee_id: employee_id = Request.find_by_id(request_id).employee_id,
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))  
    end 

#o 9 responses were local, i.e., came from developers at the location where the request originated    
    def pick_same_location_employee_id(request_id)
      loc_id = Request.find_by_id(request_id).location_id
      local_emp_ids = location_employee_ids(loc_id)
      emp_id = local_emp_ids.sample
      return emp_id
    end
     
    9.times do |n|   
      loc_id = [1..5].sample
      request_ids = location_request_ids(loc_id)
      request_id = request_ids.sample
      employee_ids = location_employee_ids(loc_id) 
      Response.create!(
              request_id: request_id,
              response: Faker::Lorem.sentences(1),
              employee_id: employee_ids[n],
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
    end 

#local request selections 
#o Some responses are selected on the same day as a response, 0some a day later, some 3 days later, and some 5
    def res_selection_date(response_date)      
      [ (response_date), (response_date + 1.day), (response_date + 3.days), (response_date + 5.days)].sample    
    end
    
    local_resp_ids = []    
    ids_for_requests_with_responses.each do |request_id|
      response_id = Response.find_by_request_id(request_id).id
      req_loc_id = Request.find_by_id(request_id).location_id
      responding_employee_id = Response.find_by_id(response_id).employee_id
      responding_employee_loc = Employee.find_by_id(responding_employee_id).location_id
      if responding_employee_loc = req_loc_id        
        local_resp_ids << response_id
      end
      local_resp_ids
    end

    7.times do |n|                      
    response_id = local_resp_ids[n]
    employee_id = Response.find_by_id(response_id).employee_id
    request_id = Response.find_by_id(response_id).request_id

    Selection.create!(
          comments: Faker::Lorem.sentences(1),      
          request_id: request_id,
          response_id: response_id,      
          employee_id: employee_id,     
          created_at: res_selection_date(Response.find_by_id(response_id).created_at),
          updated_at: res_selection_date(Response.find_by_id(response_id).created_at))   
    end    

#personal response selection
    own_response_ids = []
    own_request_ids.each do |request_id|
      own_response_ids << Response.find_by_request_id(request_id).id
    end

    response_id = own_response_ids.sample     
    Selection.create!(
          comments: Faker::Lorem.sentences(1),      
          request_id: Response.find_by_id(response_id).request_id,
          response_id: response_id,                
          employee_id: Response.find_by_id(response_id).employee_id,      
          created_at: res_selection_date(Response.find_by_id(response_id).created_at),
          updated_at: res_selection_date(Response.find_by_id(response_id).created_at))   

#response selection    
    42.times do     
    response_id = unselected_response_ids.first   

    create_selection(response_id)           
    end

  end
end



