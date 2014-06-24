class PetTiredness < ActiveRecord::Base
  before_create :initialize_tiredness
  belongs_to :pet

  def decrease(current_time)
    self.value = 10
    pet.happiness += 10
    pet.save
    pet.pet_hunger.value += 5 if pet.pet_hunger.value < 95
    pet.pet_hunger.save
    self.last_interaction = Time.now
    self.save
    @asleep = false
  end

  def increase(current_time)
    if ((current_time - self.change).round / 60) > 10 #only update if 10 minutes passed
      self.value += (current_time - self.change).round / 60 / 10
      self.change = current_time
      self.value = 100 if self.value > 100
      @asleep = true if self.value >= 90
      if @asleep
        self.decrease(current_time)
      end
    end
    self.save
  end

private
  def initialize_tiredness
    self.value = 0
    self.last_interaction = Time.now
    self.change = Time.now
  end
end
