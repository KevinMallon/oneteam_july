class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

   def responder
  	Employee.find_by_id(attributes["employee_id"])
  end
end
