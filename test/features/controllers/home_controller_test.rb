require "test_helper"

feature "landing page" do
  before do
    seed_db
  end

  scenario "redirects user to their own profile when already logged in" do
    visit root_path
    sign_in_capybara
    visit root_path
    page.must_have_content "#{users(:sam).username}'s Pets:"
  end

end
