# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  employee_id :string(255)
#  request_id  :string(255)
#  response    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Response < ActiveRecord::Base
  attr_accessible :employee_id, :request_id, :response
  belongs_to :request
  belongs_to :employee
end
