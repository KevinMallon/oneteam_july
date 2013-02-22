class Response < ActiveRecord::Base
  attr_accessible :employee_id, :request_id, :response
  belongs_to :request
  belongs_to :employee
  has_many :selections
end