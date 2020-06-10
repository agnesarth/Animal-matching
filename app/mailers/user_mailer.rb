class UserMailer < ApplicationMailer
  default from: 'animalmatching2020@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'Bienvenue chez nous!')
  end

  def new_pet_email(user)
    @user = user
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'Ton petit compagnon à quatre pattes a été ajouté!')
  end

  def new_match_email(user)
    @user = user
    @url = 'whispaw.herokuapp.com'
    mail(to: @user.email, subject: 'New match... Love is in the air!')
  end

end
