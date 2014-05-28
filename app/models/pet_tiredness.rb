class PetTiredness < ActiveRecord::Base
  before_create :initialize_tiredness
  belongs_to :pet

  def decrease
    self.value = 0
    self.last_interaction = Time.now
  end

  def increase(current_time)
    if ((current_time - self.change).round / 60) > 10 #only update if 10 minutes passed
      self.value += (current_time - self.change).round / 60 / 10
      self.change = current_time
    end
    self.value = 100 if self.value > 100
    self.decrease if self.value == 100
  end

private
  def initialize_tiredness
    self.value = 0
    self.last_interaction = Time.now
    self.change = Time.now
  end
end
