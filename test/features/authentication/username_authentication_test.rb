require "test_helper"

feature "Basic Authentication" do
  scenario "a user should be able to sign up" do
    visit root_path
    click_on "Sign Up"
    fill_in "Email", with: "newbie@localhost.com"
    fill_in "Password", with: "12341234"
    fill_in "Password confirmation", with: "12341234"
    click_on "Sign up"
    page.must_have_content "signed up successfully"
  end

  scenario "an existing user should be able to sign in" do

  end

  scenario "an existing user should not be able to sign up" do

  end

  scenario "a signed-in user should be able to sign out" do

  end
end
