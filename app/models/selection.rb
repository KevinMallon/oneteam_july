 class Selection < ActiveRecord::Base
 attr_accessible :comments, :employee_id, :request_id, :response_id, :created_at, :updated_at
 belongs_to :employee
 belongs_to :request
 belongs_to :response
end