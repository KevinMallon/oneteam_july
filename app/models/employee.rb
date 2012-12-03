class Employee < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :requests
end
