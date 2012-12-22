class Response < ActiveRecord::Base
  attr_accessible :employee_id, :request_id, :response
  belongs_to :request
  belongs_to :employee

  def responder
  	Employee.find_by_id(attributes["employee_id"])
  end
end
