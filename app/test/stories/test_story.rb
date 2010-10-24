require 'stories_helper'

class TestStory < Test::Unit::TestCase
  story "Capybara should work" do
    scenario "LOL" do
      visit '/'
    end
  end
end
