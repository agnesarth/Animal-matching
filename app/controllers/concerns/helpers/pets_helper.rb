module PetsHelper
  def current_pet?(pet)
    pet == Pet.find(current_user.default_pet_id)
  end

  def current_like(pet)
    current_pet = Pet.find(current_user.default_pet_id)
    return current_pet.likes_as_liker.where(liked_id: pet)
  end

  def liked?(pet)
    return Like.where(liker_id: @current_pet.id, liked_id: pet.id).exists?
  end

end
