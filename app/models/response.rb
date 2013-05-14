class Response < ActiveRecord::Base
  attr_accessible :employee_id, :request_id, :response, :created_at, :updated_at
  belongs_to :request
  belongs_to :employee
  has_one :evaluation

	has_many :selections  
	accepts_nested_attributes_for :selections
end