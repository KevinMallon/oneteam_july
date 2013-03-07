require "spec_helper"

describe TargetSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/target_skills").should route_to("target_skills#index")
    end

    it "routes to #new" do
      get("/target_skills/new").should route_to("target_skills#new")
    end

    it "routes to #show" do
      get("/target_skills/1").should route_to("target_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/target_skills/1/edit").should route_to("target_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/target_skills").should route_to("target_skills#create")
    end

    it "routes to #update" do
      put("/target_skills/1").should route_to("target_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/target_skills/1").should route_to("target_skills#destroy", :id => "1")
    end

  end
end
