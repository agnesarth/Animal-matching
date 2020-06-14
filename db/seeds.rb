# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

User.destroy_all
Pet.destroy_all
Like.destroy_all
User.destroy_all


# Seed User
12.times do
  new_user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "Whispaw+1",
    latitude: rand(42.421..51.053),
    longitude: rand(-4.884..8.233),
  )
  new_user.email = "#{new_user.first_name}.#{new_user.last_name}@yopmail.com"
  new_user.save
end

puts "#{User.all.size} humains crées"

# Seed Pet
20.times do
  my_pet = Pet.new(
    name: Faker::Artist.name,
    animal: ["Chat", "Chien"].sample,
    sex: Faker::Creature::Cat.gender,
    user_id: User.all.sample.id,
    age: rand(0..17),
    description: Faker::GreekPhilosophers.quote,
  )
  if my_pet.animal == "Chat"
    my_pet.breed = Faker::Creature::Cat.race
  elsif my_pet.animal == "Chien"
    my_pet.breed = Faker::Creature::Dog.race
  end
  my_pet.save
  User.find(my_pet.user_id).update(default_pet_id: my_pet.id)
end

puts "#{Pet.all.size} animaux crées"

# Like seed
40.times do
  my_like = Like.new(liker: Pet.all.sample)
  if my_like.liker.animal == "Chat"
   my_like.liked = Pet.where(animal: "Chat").sample
  elsif my_like.liker.animal == "Chien"
    my_like.liked = Pet.where(animal: "Chien").sample
  end
  back_like = my_like.liker.likes_as_liked.where(liker_id: my_like.liked)
  if back_like.exists?
    my_like.match = true
    back_like.update(match: true)
    my_like.save
  else
    my_like.save
  end
end

puts "#{Like.all.size} likes crées"

#Tag seed
10.times do
  new_tag = Tag.create(value: Faker::Coffee.intensifier)
end

puts "#{Tag.all.size} tags crées"

# Tag_pet
30.times do
  join_tag = TagPet.create(
    pet: Pet.all.sample,
    tag: Tag.all.sample,
    )
end

puts "#{TagPet.all.size} tags associés"
