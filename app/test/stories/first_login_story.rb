require 'stories_helper'

class FirstLoginStory < Test::Unit::TestCase
  test "First login" do
    visit '/login'

    assert_location '/login'
    assert page.has_content?('Login')
    assert page.has_css?('form')

    fill_in 'username', :with => 'test@sinefunc.com'
    fill_in 'password', :with => 'massive'

    click_button 'Login'

    # Go back to login page
    assert_location '/login'
    assert page.has_content?('Try again!')

    fill_in 'username', :with => 'test@sinefunc.com'
    fill_in 'password', :with => 'password'

    click_button 'Login'

    # First visit!
    assert_location '/admin/welcome'
  end
end
