require "test_helper"
require "minitest/autorun"

describe "Happiness" do
  it "should start at 100" do
    spot = Pet.create(name: "Spot", type: "Dog", gender: "Male")
    assert_equal 100, spot.happiness
  end
end
