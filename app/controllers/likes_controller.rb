class LikesController < ApplicationController
    def index
        @likes = Like.all
    end

    def show
    end

    def new
        @pet = Pet.find(params[:id])
        @like = Like.new(liker: current_pet, liked: @pet)
        if already_liker
            @like.match = true
            @like.save
        else
            @like.save
        end

    end


    private

    def pet_params
        params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age)
    end

end
