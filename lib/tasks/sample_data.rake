namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    @job_titles = ["Engineer", "Analyst", "Project Lead", "UI Specialist", "QA Specialist"]    
    @departments = ["IT", "Marketing", "Analytics", "Research"]    
    @groups = ["Development", "Interface Design","QA","Infrastructure"]    
    @locations = ["Chicago",  "Mumbai", "Houston", "San Francisco", "Boston", "London"]
    @locations_and_ids = {"Chicago"=>1, "Boston"=>2, "Houston"=>3, "San Francisco"=>4, "London"=>5,       
      "Mumbai"=>6} 
    @location_ids_emps = { 1 => 45, 2 => 20, 3 => 32, 
    4 => 14, 5 => 12, 6 => 5}

    @location_ids_emps.each do |location_id, emps|
      emps.times do
        name  = Faker::Name.name
        email = Faker::Internet.email
        password  = "password"
        Employee.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password,  
                      group: ["Development", "Interface Design", "QA", "Infrastructure"].sample.to_s,
                      location: location_id,
                      department: ["IT", "Marketing", "Analytics", "Research"].sample.to_s,
                      supervisor: Faker::Name.name,
                      years_at_company: rand(1..20),
                      job_title: ["Engineer", "Analyst", "Project Lead", "UI Specialist", "QA Specialist"].sample.to_s,
                      description: Faker::Lorem.paragraph(sentence_count = 2) )

      end
    end

#create around 120 project request posts over 6 or more months 

    def get_start_date    
      Array((Date.today - 3.months)..(Date.today + 3.months)).sample  
    end

# 3 developers posted once
    emp_id = 97
    3.times do 
      emp_id += 1
      Request.create!(                
              employee_id: emp_id,
              group: @groups.sample.to_s,
              location: location = 4,
              start_date: start_date = get_start_date,
              stop_date: start_date + rand(1..360).days,
              content: Faker::Lorem.paragraph(sentence_count = 2),
              project: Faker::Lorem.paragraph(sentence_count = 1),
              active: active = 1 )
    end

# 2 posted more than 10 requests
    14.times do
      Request.create!(
              employee_id: employee_id = 112,
              group: @groups.sample.to_s,
              location: location = 5,
              start_date: start_date = get_start_date,
              stop_date: start_date + rand(1..360).days,
              content: Faker::Lorem.paragraph(sentence_count = 2),
              project: Faker::Lorem.paragraph(sentence_count = 1),
              active: active = 1 )
    end

    12.times do
      Request.create!(
              employee_id: employee_id = 124,
              group: @groups.sample.to_s,
              location: location = 6,
              start_date: start_date = get_start_date,
              stop_date: start_date + rand(1..360).days,
              content: Faker::Lorem.paragraph(sentence_count = 2),
              project: Faker::Lorem.paragraph(sentence_count = 1),
              active: active = 1 )              
    end

#from 20 of the developers, such that:
#o The rest were in between
#o At least a few posts from all other offices
    emp_ids_for_reqs = (1..65).to_a.shuffle
    15.times do    
      x = rand(3..8)
      emp_id = emp_ids_for_reqs.pop      
      x.times do        
        Request.create!(
              employee_id: employee_id = emp_id,  
              group: @groups.sample.to_s,
              location: Employee.find_by_id(employee_id).location,
              start_date: start_date = get_start_date,                        
              stop_date: start_date + rand(1..90).days,                           
              content: Faker::Lorem.sentences(2).join(" "),
              project: Faker::Lorem.words(2).join(" ").to_s.capitalize,
              active: active = 1 )
      end                                                       
    end

#• 70 responses for those requests, such that:
#o 9 responses were local, i.e., came from developers at the office where the request originated
#o 2 responses were personal, i.e., a developer responded to their own request
#o 0 responses to any requests from Mumbai
#o All requests from London received at least 3 responses
#o Some responses occurred a day after the request, some 2 days after, some 4, and some 8

    def random_resp_date(request_date)      
      [(request_date + 1.day), (request_date + 2.days), (request_date + 4.days), (request_date + 8.days)].sample    
    end   

    # All requests from London received at least 3 responses

    employees = Employee.all     
    emp_ids = employees.map{|emp| emp.id }.shuffle  

    non_london_emp_ids = []
    employees.each do |employee|
      if employee.location != 5
        non_london_emp_ids << employee.id
      end 
    end
    non_london_emp_ids.shuffle


    london_req_ids = (4..17).to_a
      london_req_ids.each do |request_id|  
          3.times do         
              Response.create!(
                    request_id: request_id,
                    response: Faker::Lorem.sentences(1),
                    employee_id: non_london_emp_ids.pop,
                    created_at: random_resp_date(Request.find_by_id(request_id).start_date),
                    updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
          end 
      end

    #o 9 responses were local, i.e., came from developers at the office where the request originated

    non_mumbai_req_ids = []
    requests = Request.all
    requests.each do |request|
      if request.location != 6
        non_mumbai_req_ids << request.id
      end
    end
    non_mumbai_req_ids = non_mumbai_req_ids.shuffle

    7.times do
      request_id = non_mumbai_req_ids.pop
      req_location = Request.find_by_id(request_id).location
      resp_employee_ids = []
        employees.each do |employee|
          if employee.location == req_location && employee.id != Request.find_by_id(request_id).employee_id
            resp_employee_ids << employee.id
          end
        end
      Response.create!(
              request_id: request_id,
              response: Faker::Lorem.sentences(1),
              employee_id: resp_employee_ids.sample,
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
    end 

#o 2 responses were personal, i.e., a developer responded to their own request

    2.times do
      request_id = non_mumbai_req_ids.pop
      resp_employee_id = Request.find_by_id(request_id).employee_id
      Response.create!(
              request_id: request_id,
              response: Faker::Lorem.sentences(1),
              employee_id: resp_employee_id,
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
    end 

    19.times do
      request_id = non_mumbai_req_ids.pop
      resp_employee_id = emp_ids.sample
      Response.create!(
              request_id: request_id,
              response: Faker::Lorem.sentences(1),
              employee_id: resp_employee_id,
              created_at: random_resp_date(Request.find_by_id(request_id).start_date),
              updated_at: random_resp_date(Request.find_by_id(request_id).start_date))
    end         

    #local request assignments 
    #o Some responses are selected on the same day as a response, some a day later, some 3 days later, and some 5
    def res_selection_date(response_date)      
      [ (response_date), (response_date + 1.day), (response_date + 3.days), (response_date + 5.days)].sample    
    end

    7.times do |n|      
    response_id = n+2      
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
    Selection.create!(
          comments: Faker::Lorem.sentences(1),      
          request_id: Response.find_by_id(8).request_id,
          response_id: Response.find_by_id(8).id,                
          employee_id: Response.find_by_id(8).employee_id,      
          created_at: res_selection_date(Response.find_by_id(8).created_at),
          updated_at: res_selection_date(Response.find_by_id(8).created_at))    

    #response selection    
    42.times do |n|      
    response_id = n+11      
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

  end
end