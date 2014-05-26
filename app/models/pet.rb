class Pet < ActiveRecord::Base
  belongs_to :user
  scope :dogs, -> {where(type: "Dog")}
  scope :cats, -> {where(type: "Cat")}
  scope :birds, -> {where(type: "Bird")}
  scope :rabbits, -> {where(type: "Rabbit")}

end
