require 'spec_helper'

describe "StaticPages" do
  describe "GET /static_pages" do
    it "should have the content 'OneTeam'" do
      visit '/static_pages/home'
      page.should have_content('OneTeam')
    end
    end
  end
end
