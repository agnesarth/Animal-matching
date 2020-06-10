module PetsHelper
  def current_pet?(pet)
    pet == Pet.find(current_user.default_pet_id)
  end
end
