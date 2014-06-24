class PetHunger < ActiveRecord::Base
  before_create :initialize_hunger
  belongs_to :pet

  def decrease
    if self.value > 15
      self.value = 0
      pet.pet_tiredness.value -= 10 if pet.pet_tiredness.value >=10
      pet.pet_tiredness.save
      self.last_interaction = Time.now
      self.save
      return true
    end
    return false
  end

  def increase(current_time)
    if ((current_time - self.change).round / 60) > 8 #only update if 8 minutes passed
      self.value += (current_time - self.change).round / 60 / 8
      self.change = current_time
    end
    self.value = 100 if self.value > 100
    self.save
  end

private
  def initialize_hunger
    self.value = 30
    self.last_interaction = Time.now
    self.change = Time.now
  end
end
