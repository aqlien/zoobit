require "test_helper"

feature "Basic Devise Authentication" do
  scenario "a user should be able to sign up" do
    visit root_path
    click_on I18n.t(:sign_up_link)
    fill_in "Username", with: "newbie" #Username parameter added, required
    fill_in "Email", with: "newbie@localhost.com"
    fill_in "Password", with: "12341234"
    fill_in "Password confirmation", with: "12341234"
    click_on "Sign up"
    page.must_have_content I18n.t("devise.registrations.signed_up")
  end

  scenario "an existing user should be able to sign in" do
    visit root_path
    sign_in
  end

  scenario "an non-existing user should not be able to sign in" do
    visit root_path
    sign_in("randomjoe@localhost.com", "12341234", true)
    page.must_have_content I18n.t("devise.failure.not_found_in_database")
  end

  scenario "a signed-in user should be able to sign out" do
    visit root_path
    sign_in
    page.must_have_content I18n.t("devise.sessions.signed_in")
    click_on I18n.t(:sign_out_link)
    page.must_have_content I18n.t("devise.sessions.signed_out")
  end
end

feature "Username Authentication" do
  scenario "a user should be able to sign in with a username" do
    visit root_path
    sign_in(users(:sam).username, "password")
    page.must_have_content I18n.t("devise.sessions.signed_in")
  end
end
