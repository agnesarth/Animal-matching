class LikesController < ApplicationController

    def index
        @likes = Like.all
    end

    def show
        @pet = Pet.find(params[:id])
        @likes = current_pet.likes
        @matches = @likes.where(match: true)
    end

    def new
        @like = Like.new
    end 

    def create
        @pet = Pet.find(params[:id])
        @like = Like.new(liker: current_pet, liked: @pet)
        # already_liked() and matches_back() are defined in application_controller.rb
        if already_liked(current_pet, @pet)
            @like.match = true
            matches_back(current_pet, @pet)
            @like.save
        else
            @like.save
        end

    end


    private

    def pet_params
        params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age, :id)
    end

end
