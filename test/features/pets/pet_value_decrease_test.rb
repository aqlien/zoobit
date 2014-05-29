require "test_helper"

describe "hunger decrease" do
  before do
    @pet = Pet.create(name: "Rambo", type: "Bird", gender: "Male")
  end

  it "should reset hunger to 0" do
    assert_equal 30, @pet.pet_hunger.value
    @pet.pet_hunger.decrease
    assert_equal 0, @pet.pet_hunger.value
  end

  it "should have no effect if hunger is low" do
    @pet.pet_hunger.value = 10
    assert_equal 10, @pet.pet_hunger.value
    @pet.pet_hunger.decrease
    assert_equal 10, @pet.pet_hunger.value
  end
end

describe "boredom decrease" do
  before do
    @pet = Pet.create(name: "Vickie", type: "Rabbit", gender: "Female")
  end

  it "should reset boredom to 0" do
    assert_equal 35, @pet.pet_boredom.value
    @pet.pet_boredom.decrease
    assert_equal 25, @pet.pet_boredom.value
  end

  it "should have no effect if boredom is low" do
    @pet.pet_boredom.value = 5
    assert_equal 5, @pet.pet_boredom.value
    @pet.pet_boredom.decrease
    assert_equal 5, @pet.pet_boredom.value
  end
end

describe "tiredness decrease" do
  before do
    @pet = Pet.create(name: "Vickie", type: "Rabbit", gender: "Female")
  end

  it "should reset tiredness to 0" do
    @pet.pet_tiredness.value = 90
    assert_equal 90, @pet.pet_tiredness.value
    @pet.pet_tiredness.decrease
    assert_equal 0, @pet.pet_tiredness.value
  end

  it "should make the pet sleep when at or over 100" do
    @pet.pet_tiredness.value = 100
    assert_equal 100, @pet.pet_tiredness.value
    @pet.pet_tiredness.increase(Time.now)
    assert_equal 0, @pet.pet_tiredness.value

    @pet.pet_tiredness.value = 105
    assert_equal 105, @pet.pet_tiredness.value
    @pet.pet_tiredness.increase(Time.now)
    assert_equal 0, @pet.pet_tiredness.value
  end
end
