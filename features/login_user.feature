Feature: Can login and logout
  As an user
  I can login/logout

  Scenario: I can Login
    Given a user
    When I go to home page
    Then I can login
