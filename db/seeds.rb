# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

#User.destroy_all
Pet.destroy_all

# Seed Pet
20.times do
  Pet.create!(
    name: Faker::Artist.name,
    animal: Faker::Creature::Animal.name,
    breed: Faker::Creature::Cat.race,
    chip_number: Faker::Alphanumeric.alphanumeric(number: 5),
    sex: Faker::Creature::Cat.gender,
    age: Faker::Number.number(digits: 1) ,
  )
end