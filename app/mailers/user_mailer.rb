class UserMailer < ApplicationMailer
  default from: 'animalmatching2020@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'Bienvenue chez nous!')
  end

  def new_pet_email(pet)
    @pet = pet
    @url = 'whispaw.herokuapp.com'
    mail(to: @pet.user.email, subject: 'Tu as ajouté un nouveau petit compagnon à quatre pattes')
  end

  def new_match_email1(like)
    pet = Pet.find(like.liker_id)
    @user = User.find(pet.user_id)
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'New match... Love is in the air!')
  end

  def new_match_email2(like)
    pet = Pet.find(like.liked_id)
    @user = User.find(pet.user_id)
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'New match... Love is in the air!')
  end
end
