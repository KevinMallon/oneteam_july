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
  attr_accessible :employee_id, :client, :group, :location, :project
  attr_accessible :content, :skills_needed, :start_date, :stop_date, :active
  attr_accessible :skill_ids, :skills_needed_ids

  belongs_to :employee , dependent: :destroy
  belongs_to :selections

  validates_presence_of :employee_id

  has_many :responses, :dependent => :destroy
  
  has_many :skills, dependent: :destroy, :source => :skill
  has_many :request_skills, dependent: :destroy
  has_many :skills_needed, :through => :request_skills, :source => :skill

  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :request_skills
  
  validate :later_stop_date  

  def later_stop_date    
    if stop_date < start_date           
      errors.add(:end_date,  "End Date must be later than start_date")    
    end  
  end

  def progress_status
    if Date.today > start_date && stop_date > Date.today
      return "In Progress"
    elsif Date.today < start_date 
      return "Not Started" 
    elsif Date.today > stop_date 
      return "Project completion date has passed" 
    end
  end

  def active_status(request)
    if request.active = "1"
      return "Active"
    else
      return "Cancelled"
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
    self.request_skills.delete_if(&:empty?).map &:skill_id
  end

  def skills_needed_ids=(skills_needed_ids)
    self.request_skills = skills_needed_ids.delete_if(&:empty?).map {|id| RequestSkill.new({:skill_id => id})}
  end


end

