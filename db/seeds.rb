# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

original = User.create(username: "Admin", email: "admin@zoobit.net", id: 1, password: "zoobit123")
original.pets << Dog.create(name: "Kayenne", breed: "White German Shepherd", gender: "female", happiness: 100)
original.pets << Cat.create(name: "Cherri", breed: "Tuxedo", gender: "female", happiness: 100)
original.pets << Bird.create(name: "Aram", breed: "Violet Parakeet", gender: "male", happiness: 100)
original.pets << Rabbit.create(name: "Mitsuki", breed: "Hotot", gender: "male", happiness: 100)
