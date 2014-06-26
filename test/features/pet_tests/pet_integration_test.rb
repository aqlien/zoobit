require "test_helper"

feature "edit a pet test" do
  before do
    seed_db
  end
  scenario "rename a pet" do
    visit root_path
    sign_in_capybara
    visit edit_pet_path(pets :tweets)
    fill_in "pet[name]", with: "New animal!"
    click_on "Rename Pet"
    page.must_have_content "New animal!"
  end
end

feature "abandon a pet" do
  scenario "abandonment" do
    User.create(username: "Zoobit Shelter", email: "shelter@zoobit.net", id: 1, password: "zoobit123")
    visit root_path
    sign_in_capybara
    visit user_path(users :sam)
    first(:link, "Abandon").click
    page.must_have_content "You abandoned Whiskers."

    #adopt back from the shelter
    visit new_pet_path
    click_on "new Pet"
    page.must_have_content "Whiskers"
    first(:link, "Adopt Pet").click
    page.must_have_content I18n.t("pets.new")
  end
end

feature "interacting with a pet" do
  before do
    seed_db
  end

  scenario "playing" do
    visit root_path
    sign_in_capybara
    visit user_path(users :sam)
    click_on "Tweety"
    click_on "Play"
    page.must_have_content I18n.t("pets.play_success", name: "Tweety")
    20.times {click_on "Play"}
    page.must_have_content I18n.t("pets.play_failure", name: "Tweety")
  end
  scenario "feeding" do
    visit root_path
    sign_in_capybara
    visit user_path(users :sam)
    click_on "Tweety"
    click_on "Feed"
    page.must_have_content I18n.t("pets.feed_success", name: "Tweety")
    7.times {click_on "Feed"}
    page.must_have_content I18n.t("pets.feed_failure", name: "Tweety")
  end
end

feature "Shelter" do
  before do
    seed_db
  end

  scenario "filter pets" do
    visit root_path
    sign_in_capybara
    visit "/shelter"
    click_on "Dogs"
    page.has_no_content?("Cat")
    page.has_no_content?("Bird")
    page.has_no_content?("Rabbit")

    click_on "Cats"
    page.has_no_content?("Dog")
    page.has_no_content?("Bird")
    page.has_no_content?("Rabbit")

    click_on "Birds"
    page.has_no_content?("Cat")
    page.has_no_content?("Dog")
    page.has_no_content?("Rabbit")

    click_on "Rabbits"
    page.has_no_content?("Cat")
    page.has_no_content?("Bird")
    page.has_no_content?("Dog")
  end
end
