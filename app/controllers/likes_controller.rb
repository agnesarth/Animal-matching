class LikesController < ApplicationController
  before_action :current_pet, only: [:create,:update,:destroy]

  def index
    @my_likes = Like.where(match: false,liker_id: current_pet.id)
  end

  def show
    @my_likes = Like.where(match: false,liker_id: current_pet.id)
    @my_matches = Like.where(match: true,liker_id: current_pet.id)
  end

  def new
    @like = Like.new
  end

  def create
    @pet = Pet.find(params['pet_id'])
    @like = Like.new(liker_id: current_pet.id, liked_id: @pet.id)
    respond_to do |format|
      if @like.save!
        format.html { redirect_to pets_path, notice: "J'adore!" }
        format.js { }
      end
    end
  end

  def destroy
    @pet = Pet.find(params['pet_id'])
    @like = Like.find(params['id'])
    @like.destroy
  end

  def current_pet
    return current_pet = Pet.find(current_user.default_pet_id)
  end


end
