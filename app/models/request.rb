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
  attr_accessible :skills_needed_ids
  attr_accessor :skills_needed_ids
  
  belongs_to :employee  
  belongs_to :selections

  has_many :responses, :dependent => :destroy
  
  has_many :skills, dependent: :destroy, :source => :skill
  has_many :request_skills, dependent: :destroy
  has_many :skills_needed, :through => :request_skills, :source => :skill

  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :request_skills


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

def skills_needed_ids
  [skills_needed].join(",")   #getter
end

end

