Feature: See Lessons
  Users can list available lessons

  Scenario: List available lessons
    Given I am a loggued user
    And a lesson call "learn perl" exist
    When I go to lessons page
    Then I can see lesson call "learn perl"
