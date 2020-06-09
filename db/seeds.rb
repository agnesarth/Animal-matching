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
Like.destroy_all

pet_nb = 0
like_nb = 0

# Seed Pet
20.times do
  my_pet = Pet.new(
    name: Faker::Artist.name,
    animal: ["chat", "chien"].sample,
    chip_number: Faker::Alphanumeric.alphanumeric(number: 5),
    sex: Faker::Creature::Cat.gender,
    age: rand(0..17),
  )
  if my_pet.animal == "chat"
    my_pet.breed = Faker::Creature::Cat.race
  elsif my_pet.animal == "chien"
    my_pet.breed = Faker::Creature::Dog.race
  end
  my_pet.save
  pet_nb += 1
end

puts "#{pet_nb} animaux crées"

# Like seed
20.times do
  my_like = Like.new(liker: Pet.all.sample)
  if my_like.liker.animal == "chat"
   my_like.liked = Pet.where(animal: "chat").sample
  elsif my_like.liker.animal == "chien"
    my_like.liked = Pet.where(animal: "chien").sample
  end
  my_like.save
  like_nb += 1
end

puts "#{like_nb} likes crées"