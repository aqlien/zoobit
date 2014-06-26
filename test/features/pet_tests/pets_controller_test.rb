require "test_helper"


feature "pet controller" do
  before do
    seed_db
    @user = users(:sam)
  end

  scenario "view all your pets" do
    visit root_path
    sign_in_capybara
    visit user_path(@user)
    page.must_have_content("Whiskers")
    page.must_have_content("Tweety")
  end

  scenario "view someone else's pets" do
    visit user_path(@user)
    page.must_have_content("Whiskers")
    page.must_have_content("Tweety")
  end

end
