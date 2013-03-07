require "spec_helper"

describe EmployeeSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/employee_skills").should route_to("employee_skills#index")
    end

    it "routes to #new" do
      get("/employee_skills/new").should route_to("employee_skills#new")
    end

    it "routes to #show" do
      get("/employee_skills/1").should route_to("employee_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/employee_skills/1/edit").should route_to("employee_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/employee_skills").should route_to("employee_skills#create")
    end

    it "routes to #update" do
      put("/employee_skills/1").should route_to("employee_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/employee_skills/1").should route_to("employee_skills#destroy", :id => "1")
    end

  end
end
