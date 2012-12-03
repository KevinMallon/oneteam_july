class Request < ActiveRecord::Base
  attr_accessible :client, :employee_id, :group, :location, :project, :request, :skills_needed, :start_date, :stop_date
  belongs_to :employee
end
