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

describe "fullness and energy" do
  before do
    @spot = Pet.create(name: "Spot", type: "Dog", gender: "Male")
    @spot.last_update = Time.now - (60*60*8) #8 hours ago
  end
  it "should start at 100" do
    assert_equal 100, @spot.fullness
  end

  it "should decrease when needed" do
    @spot.fullness = 30
    assert_equal 30, @spot.fullness
    @spot.last_feeding = Time.now - (60*60*8) #8 hours ago
    @spot.update_happiness
    assert_equal 0, @spot.fullness
  end

  it "won't decrease if it hasn't been long enough" do
    @spot.fullness = 70
    @spot.last_feeding = Time.now - 60 #60 seconds ago
    @spot.update_happiness
    assert_equal 70, @spot.fullness
  end

  it "won't decrease too often" do
    current_time = Time.now
    @spot.energy = 70
    @spot.last_rest = current_time - 60 * 10 #10 minutes ago
    @spot.update_happiness
    assert_equal 69, @spot.energy
    @spot.update_happiness
    assert_equal 69, @spot.energy
  end
end
