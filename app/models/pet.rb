class Pet < ActiveRecord::Base
  belongs_to :user
  before_create :initialize_pet

  scope :dogs, -> {where(type: "Dog")}
  scope :cats, -> {where(type: "Cat")}
  scope :birds, -> {where(type: "Bird")}
  scope :rabbits, -> {where(type: "Rabbit")}

  def initialize_pet
    self.happiness = 100
    self.energy = 100
    self.fullness = 100
    self.last_interaction = Time.now
    self.last_feeding = Time.now
    self.last_rest = Time.now
    self.last_update = Time.now
    self.img_loc = "#{self.type.downcase}_happy.jpg"
  end

  def update_happiness
    current_time = Time.now
    if (current_time - self.last_update).round/ 60 > 8
      decrease_fullness(current_time)
      decrease_energy(current_time)
      self.last_update = current_time
    end
    self.happiness = (self.fullness + self.energy*1.5)/2
    reset_below_zero
  end

  def decrease_fullness(current_time)
    # Time in seconds since last feeding converted to minutes, every 8 minutes
    self.fullness -= (current_time - self.last_feeding).round/ 60 / 8
    reset_below_zero
  end

  def decrease_energy(current_time)
    if self.energy < 10
      self.last_rest = Time.now
      self.energy = 100
    end
    self.energy -= (current_time - self.last_rest).round / 60 / 10
    reset_below_zero
  end

  def reset_below_zero
    self.happiness = 0 if self.happiness < 0
    self.fullness = 0 if self.fullness < 0
    self.energy = 0 if self.energy < 0
  end
end
