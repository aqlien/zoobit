require "test_helper"
require "minitest/autorun"



describe "Happiness" do
  before do
    @spot = Pet.create(name: "Spot", type: "Dog", gender: "Male")
  end
  it "should start at 100" do
    assert_equal 100, @spot.happiness
  end
end

describe "fullness" do
  before do
    @spot = Pet.create(name: "Spot", type: "Dog", gender: "Male")
  end
  it "should start at 100" do
    assert_equal 100, @spot.fullness
  end

  it "should decrease when needed" do
    @spot.fullness = 30
    assert_equal 30, @spot.fullness
    @spot.last_feeding = Time.now - (60*60*8) #8 hours ago
    @spot.decrease_fullness(Time.now)
    assert_equal 0, @spot.fullness
  end

  it "won't decrease if it hasn't been long enough" do
    @spot.fullness = 70
    @spot.last_feeding = Time.now - 60 #60 seconds ago
    @spot.decrease_fullness(Time.now)
    assert_equal 70, @spot.fullness
  end
end
