# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(username: "Admin", email: "admin@zoobit.net", id: 1, password: "zoobit123")
admin.pets << Pet.create(name: "Kayenne", type: "Dog", breed: "White German Shepherd", gender: "female", happiness: 100)
admin.pets << Pet.create(name: "Cherri", type: "Cat", breed: "Tuxedo", gender: "female", happiness: 100)
admin.pets << Pet.create(name: "Monty", type: "Cat", breed: "Flame-point Ragdoll", gender: "male", happiness: 100)
admin.pets << Pet.create(name: "Aram", type: "Bird", breed: "Violet Parakeet", gender: "male", happiness: 100)
admin.pets << Pet.create(name: "Mitsuki", type: "Rabbit", breed: "Hotot", gender: "male", happiness: 100)
