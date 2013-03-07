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
  attr_accessible :employee_id, :title, :client, :group, :location, :project
  attr_accessible :content, :skills_needed, :start_date, :stop_date, :active
  belongs_to :employee  
  belongs_to :selections
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :responses  
  has_many :skills, :through => :request_skills

  def progress_status
    if Date.today > start_date 
      return "In Progress"
    else 
      return "Not Started" 
    end
  end


  def applied_status(an_employee)
    responses.each do |response| 
      if response.employee == an_employee
        return "applied" 
      end
    end
  return "apply"
  end

end

