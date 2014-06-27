require "test_helper"

feature "Basic Devise Authentication" do
  before do
    seed_db
  end

  scenario "a user should be able to sign up" do
    visit "/users/sign_up"
    fill_in "*Username:", with: "newbie"
    fill_in "*Email:", with: "newbie@localhost.com"
    fill_in "user_password", with: "12341234"
    fill_in "user_password_confirmation", with: "12341234"
    first(:button, "Sign Up").click
    page.must_have_content "Signed in as newbie"
  end

  scenario "an existing user should be able to sign in" do
    visit root_path
    sign_in_capybara
  end

  scenario "an non-existing user should not be able to sign in" do
    visit root_path
    sign_in_capybara("randomjoe@localhost.com", "12341234", true)
    page.must_have_content I18n.t("devise.failure.not_found_in_database")
  end

  scenario "a signed-in user should be able to sign out" do
    visit root_path
    sign_in_capybara
    page.must_have_content "Signed in as ZoobitAdmin"
    first(:link, I18n.t(:sign_out_link)).click
    # page.must_have_content I18n.t("devise.sessions.signed_out") #Attempting to visit root_path currently brings non-signed-in users to the login page. Will fix.
  end
end

feature "Username Authentication" do
  before do
    seed_db
  end

  scenario "a user should be able to sign in with a username" do
    visit root_path
    sign_in_capybara
    page.must_have_content "Signed in as ZoobitAdmin"
  end
end
