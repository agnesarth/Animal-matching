# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

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
    animal: [0,1].sample,
    sex: Faker::Creature::Cat.gender,
    user_id: User.all.sample.id,
    birthdate: Faker::Date.birthday($format = 'Y-m-d', min_age: 0, max_age: 20),
    description: Faker::GreekPhilosophers.quote,
  )
  if my_pet.chat?
    my_pet.breed = Faker::Creature::Cat.race
  elsif my_pet.chien?
    my_pet.breed = Faker::Creature::Dog.race
  end
  my_pet.save
  User.find(my_pet.user_id).update(default_pet_id: my_pet.id)
end

puts "#{Pet.all.size} animaux crées"

# Like seed
30.times do
  my_like = Like.new(liker: Pet.all.sample)
  if my_like.liker.chat?
   my_like.liked = Pet.all.chat.sample
  elsif my_like.liker.chien?
    my_like.liked = Pet.all.chien.sample
  end
  my_like.save
  reverse_liker_pet = Pet.find(my_like.liked_id)
  reverse_liked_pet = Pet.find(my_like.liker_id)
  if Like.where(liked_id: reverse_liked_pet.id, liker_id: reverse_liker_pet.id).exists?
    @title = "#{reverse_liker_pet.name} et #{reverse_liked_pet.name}"
    @chatroom = Chatroom.new
    @chatroom = reverse_liker_pet.user.chatrooms.build(title: @title)
    @chatroom.users << reverse_liker_pet.user
    @chatroom.users << reverse_liked_pet.user
    @chatroom.save
  end
end

puts "#{Like.all.size} likes crées"
puts "#{Chatroom.all.size} chatrooms crées"

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
