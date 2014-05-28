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

describe "Hunger" do
  before do
    @sylvie = Cat.create(name:"Sylvie", gender:"female")
    @time = Time.now
    @sylvie.pet_hunger.last_interaction = @time - (60*60*8)
    #last fed 8 hours ago
  end

  it "should start at 30" do
    assert_equal 30, @sylvie.pet_hunger.value
  end

  it "increases by 1 about every 8 minutes" do
    @sylvie.pet_hunger.change = @time - (60*7)
    @sylvie.update_happiness(@time)
    assert_equal 30, @sylvie.pet_hunger.value
    #no increase, hasn't been long enough

    @sylvie.pet_hunger.change = @time - (60*9)
    @sylvie.update_happiness(@time)
    assert_equal 31, @sylvie.pet_hunger.value
    #increase by 1 in 8 minutes

    #refresh again
    @sylvie.update_happiness(@time)
    assert_equal 31, @sylvie.pet_hunger.value
    #no increase, hasn't been long enough since last update
  end
end

describe "Boredom" do
  before do
    @sylvie = Cat.create(name:"Sylvie", gender:"female")
    @time = Time.now
    @sylvie.pet_boredom.last_interaction = @time - (60*60*8)
    #last played with 8 hours ago
  end

  it "should start at 35" do
    assert_equal 35, @sylvie.pet_boredom.value
  end

  it "increases by 1 about every 5 minutes" do
    @sylvie.pet_boredom.change = @time - (60*2)
    @sylvie.update_happiness(@time)
    assert_equal 35, @sylvie.pet_boredom.value
    #no increase, hasn't been long enough

    @sylvie.pet_boredom.change = @time - (60*6)
    @sylvie.update_happiness(@time)
    assert_equal 36, @sylvie.pet_boredom.value
    #increase by 1 after 5 minutes

    #refresh again
    @sylvie.update_happiness(@time)
    assert_equal 36, @sylvie.pet_boredom.value
    #no increase, hasn't been long enough since last update

    @sylvie.pet_boredom.change = @time - (60*480)
    @sylvie.update_happiness(@time)
    assert_equal 100, @sylvie.pet_boredom.value
  end
end
