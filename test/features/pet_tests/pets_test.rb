require "test_helper"

feature "Pet Creation" do
  before do
    seed_db
  end

  scenario "As a developer, I want a model for each species to track pet attributes." do
    kayenne = Dog.create(name: "Kayenne", type:"Dog", gender:"Female")
    assert_equal kayenne.name, "Kayenne"
    assert_equal kayenne.type, "Dog"
    assert_equal kayenne.gender, "Female"
  end

  scenario "As a user I want to be able to get a new pet so I can use this site." do
    visit root_path
    sign_in_capybara
    click_on "new Pet"
    first(:link, "Adopt Pet").click
    page.must_have_content I18n.t("pets.new")
  end
end

# Capybara has trouble checking flash messages. :(
# feature "Pet Behavior" do
#   before do
#     seed_db
#   end

#   scenario "happy pet" do

#   end

#   scenario "hungry pet" do

#   end

#   scenario "tired pet" do

#   end

#   scenario "bored pet" do

#   end

# end

