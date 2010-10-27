require 'stories_helper'

class Main
  get '/lalala' do
    raise "Yo"
  end
end

class VisitStory < Test::Unit::TestCase
  test "Pages should not have errors" do
    Main.seed :sample

    s = Capybara::Session.new(:rack_test, Main)

    s.visit '/login'
    s.fill_in 'username', :with => Main.default_user
    s.fill_in 'password', :with => Main.default_password
    s.click_button 'Login'

    assert_admin '/admin', s
    assert_admin '/admin/settings/database', s
    assert_admin '/user/me/edit', s
    assert_admin '/user/1/edit', s

    assert_front '/home', s
    assert_front '/', s
    assert_front '/about-us', s
  end
end
