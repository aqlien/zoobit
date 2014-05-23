require "test_helper"

feature "Pet Creation" do
  scenario "As a developer, I want a model for each species to track pet attributes." do
    kayenne = Dog.create("Kayenne", "WGSD", "female")
    assert_equal kayenne.name, "Kayenne"
    assert_equal kayenne.breed, "WGSD"
    assert_equal kayenne.gender, "female"
    respond_to kayenne.happiness
  end

  scenario "As a user I want to be able to get a new pet so I can use this site." do
  end
end

