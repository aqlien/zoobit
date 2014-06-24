class PetTiredness < ActiveRecord::Base
  before_create :initialize_tiredness
  belongs_to :pet

  def decrease(current_time)
    if ((current_time - self.change).round / 60) > 10 #only update if 10 minutes passed
      self.value = 10
      pet.happiness += 10
      pet.save
      pet.pet_hunger.value += 5 if pet.pet_hunger.value < 95
      pet.pet_hunger.save
    end
    self.last_interaction = Time.now
    self.save
  end

  def increase(current_time)
    if ((current_time - self.change).round / 60) > 10 #only update if 10 minutes passed
      self.value += (current_time - self.change).round / 60 / 10
      self.change = current_time
    end
    self.value = 100 if self.value > 100
    self.decrease(current_time) if self.value == 100 #simulates sleeping, doesn't take any time yet
    self.save
  end

private
  def initialize_tiredness
    self.value = 0
    self.last_interaction = Time.now
    self.change = Time.now
  end
end
