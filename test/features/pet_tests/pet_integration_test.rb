require "test_helper"

feature "edit a pet test" do
  scenario "rename a pet" do
    visit root_path
    sign_in_capybara
    within("//div[class='row Tweety']") do
      click_on "Change Name"
    end
    fill_in "Name", with: "New animal!"
    click_on "Rename Pet"
    page.must_have_content I18n.t("pets.new_name")
  end
end

feature "abandon a pet" do
  scenario "abandonment" do
    User.create(username: "Zoobit Shelter", email: "shelter@zoobit.net", id: 1, password: "zoobit123")
    visit root_path
    sign_in_capybara
    within("//div[class='row Tweety']") do
      click_on "Abandon"
    end
    page.must_have_content "You abandoned Tweety"

    #adopt back from the shelter
    click_on "new Pet"
    page.must_have_content "Tweety"
    within("//div[class='row Tweety']") do
      click_on "Adopt Pet"
    end
    page.must_have_content I18n.t("pets.new")
  end
end

feature "interacting with a pet" do
  scenario "playing" do
    visit root_path
    sign_in_capybara
    click_on "Tweety"
    click_on "Play"
    page.must_have_content I18n.t("pets.play_success", name: "Tweety")
    3.times {click_on "Play"}
    page.must_have_content I18n.t("pets.play_failure", name: "Tweety")
  end
  scenario "feeding" do
    visit root_path
    sign_in_capybara
    click_on "Tweety"
    click_on "Feed"
    page.must_have_content I18n.t("pets.feed_success", name: "Tweety")
    click_on "Feed"
    page.must_have_content I18n.t("pets.feed_failure", name: "Tweety")
  end
end

