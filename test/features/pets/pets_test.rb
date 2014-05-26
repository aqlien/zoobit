require "test_helper"

feature "Pet Creation" do
  scenario "As a developer, I want a model for each species to track pet attributes." do
    kayenne = Dog.create(name: "Kayenne", type:"Dog", gender:"female")
    assert_equal kayenne.name, "Kayenne"
    assert_equal kayenne.type, "Dog"
    assert_equal kayenne.gender, "female"
    #respond_to kayenne.happiness
  end

  scenario "As a user I want to be able to get a new pet so I can use this site." do
  end
end

