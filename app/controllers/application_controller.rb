class ApplicationController < ActionController::Base
    def current_pet
        my_pets = current_user.pets
        
    end
end
