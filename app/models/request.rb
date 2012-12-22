# == Schema Information
#
# Table name: requests
#
#  id            :integer          not null, primary key
#  employee_id   :integer
#  group         :string(255)
#  location      :string(255)
#  skills_needed :string(255)
#  start_date    :date
#  stop_date     :date
#  request       :string(255)
#  client        :string(255)
#  project       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Request < ActiveRecord::Base
  attr_accessible :employee_id, :client, :group, :location, :project, :request, :skills_needed, :start_date, :stop_date
  
  belongs_to :employee
  
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :responses
  has_many :responders, :through => :responses, source: :employee_id  
		
end
