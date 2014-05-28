class PetBoredom < ActiveRecord::Base
  before_create :initialize_boredom
  belongs_to :pet

  def decrease
    if self.value > 10
      self.value -= 20
      self.last_interaction = Time.now
      return true
    end
    return false
  end

  def increase(current_time)
    if ((current_time - self.change).round / 60) > 5 #only update if 5 minutes passed
      self.value += (current_time - self.change).round / 60 / 5
      self.change = current_time
    end
    self.value = 100 if self.value > 100
  end

private
  def initialize_boredom
    self.value = 35
    self.last_interaction = Time.now
    self.change = Time.now
  end
end
