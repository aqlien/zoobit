require "test_helper"
require "minitest/autorun"

class PetValueIncreaseTest < ActiveSupport::TestCase

  def setup
    @time = Time.now
    @pet = pets(:tweets)
  end

  describe "Happiness" do
    it "should start at 100" do
      assert_equal 100, @pet.happiness
    end

    it "should be recalculated automatically" do
      @pet.pet_boredom.value = 10
      @pet.pet_hunger.value = 10
      @pet.pet_tiredness.value = 10
      @pet.update_happiness(@time)
      assert_equal 90, @pet.happiness

      @pet.pet_boredom.value = 80
      @pet.pet_hunger.value = 80
      @pet.pet_tiredness.value = 80
      @pet.update_happiness(@time)
      assert_equal 20, @pet.happiness
    end
  end

  describe "Hunger Increase" do
    it "should start at 30" do
      assert_equal 30, @pet.pet_hunger.value
    end

    it "increases by 1 about every 8 minutes" do
      @pet.pet_hunger.change = @time - (60*7)
      @pet.update_happiness(@time)
      assert_equal 30, @pet.pet_hunger.value
      #no increase, hasn't been long enough

      @pet.pet_hunger.change = @time - (60*9)
      @pet.update_happiness(@time)
      assert_equal 31, @pet.pet_hunger.value
      #increase by 1 in 8 minutes

      #refresh again
      @pet.update_happiness(@time)
      assert_equal 31, @pet.pet_hunger.value
      #no increase, hasn't been long enough since last update
    end
  end

  describe "Boredom Increase" do
    it "should start at 35" do
      assert_equal 35, @pet.pet_boredom.value
    end

    it "increases by 1 about every 5 minutes" do
      @pet.pet_boredom.change = @time - (60*2)
      @pet.update_happiness(@time)
      assert_equal 35, @pet.pet_boredom.value
      #no increase, hasn't been long enough

      @pet.pet_boredom.change = @time - (60*6)
      @pet.update_happiness(@time)
      assert_equal 36, @pet.pet_boredom.value
      #increase by 1 after 5 minutes

      #refresh again
      @pet.update_happiness(@time)
      assert_equal 36, @pet.pet_boredom.value
      #no increase, hasn't been long enough since last update

      @pet.pet_boredom.change = @time - (60*480)
      @pet.update_happiness(@time)
      assert_equal 100, @pet.pet_boredom.value
    end
  end

  describe "Tiredness Increase" do
    it "should start at 0" do
      assert_equal 0, @pet.pet_tiredness.value
    end

    it "increases by 1 about every 10 minutes" do
      @pet.pet_tiredness.change = @time - (60*7)
      @pet.update_happiness(@time)
      assert_equal 0, @pet.pet_tiredness.value
      #no increase, hasn't been long enough

      @pet.pet_tiredness.change = @time - (60*11)
      @pet.update_happiness(@time)
      assert_equal 1, @pet.pet_tiredness.value
      #increase by 1 in 10 minutes

      #refresh again
      @pet.update_happiness(@time)
      assert_equal 1, @pet.pet_tiredness.value
      #no increase, hasn't been long enough since last update
    end
  end
end

