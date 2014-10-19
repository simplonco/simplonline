Feature: Update profil
  Remote user can update profil

  Scenario: Can access to edit profil
    Given I am a loggued remote user
    When I go to edit profil page
    Then I can see user form
