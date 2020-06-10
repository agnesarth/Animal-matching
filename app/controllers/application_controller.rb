class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def already_liked(current_pet, other_pet)
        return current_pet.liked_likes.where(liker_id: other_pet).exists?
    end

    def matches_back(current_pet, other_pet)
        back_like = current_pet.liked_likes.where(liker_id: other_pet)
        back_like.update(match: true)
        back_like.save
    end

    def unmatch(current_pet, other_pet)
        iam_liked_ids = current_pet.liked_likes.all
        unmatched = iam_liked_ids.where(liker: other_pet)
        unmatched.match = false
        unmatched.save
    end

    def user_default_pet(current_user, my_pet)
        if current_user.default_pet_id.nil?
        current_user.update(default_pet_id: my_pet.id)
        current_user.save
        end
    end

end
