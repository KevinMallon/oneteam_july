Feature: Static Page Integration

  Scenario: Unsuccessful static page integration
    Given a user visits the home page
    Then he should not see 'OneTeam'

  Scenario: Successful static page integration
    Given a user visits the home page
    Then he should see 'OneTeam'
end
  
