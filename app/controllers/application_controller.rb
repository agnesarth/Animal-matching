class ApplicationController < ActionController::Base
    def current_pet
        my_pets = current_user.pets
        
    end


    def already_liked(current_pet, other_pet)
        return current_pet.liked_likes.where(liker_id: other_pet).exists?
    end

    def matches_back(current_pet, other_pet)
        back_like = current_pet.liked_likes.where(liker_id: other_pet)
        back_like.update(match: true)
        back_like.save
    end 

end
