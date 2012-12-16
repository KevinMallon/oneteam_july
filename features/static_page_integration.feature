Feature: Static Page Integration

  Scenario: Unsuccessful static page integration
    Given a employee visits the home page
    Then he should not see 'OneTeam'

  Scenario: Successful static page integration
    Given a employee visits the home page
    Then he should see 'OneTeam'
end
  
