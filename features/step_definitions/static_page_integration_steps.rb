Given /^a user visits the home page$/ do
  visit index
end

  Scenario: Successful static page integration
  Given /^a user visits the home page$/ do
  visit index
  Then /^he should not see 'OneTeam'$/ do
  page.shouldnot have_selector('OneTeam')

  Scenario: Successful static page integration
  Given /^a user visits the home page$/ do
  visit index
  Then /^he should see 'OneTeam'$/ do
  page.should have_selector('OneTeam')
end