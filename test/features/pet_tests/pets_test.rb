require "test_helper"

feature "Pet Creation" do
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
    ##Users cannot create their own pets anymore, they must adopt
    # fill_in "Name", with: pets(:spot).name
    # select pets(:spot).type, from: "Type"
    # select pets(:spot).gender, from: "Gender"
    click_on "Adopt Pet"
    page.must_have_content I18n.t("pets.new")
  end
end

