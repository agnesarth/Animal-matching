class LikesController < ApplicationController
  before_action :current_pet, only: [:create,:update,:destroy]

  def index
    @likes = Like.all
  end

  def show
    #array containing all likes from the current_pet
    @my_likes_ids = current_pet.liker_likes.all
    #array containing all likes towards the current_pet
    @iam_liked_ids = current_pet.liked_likes.all
    @matches = @my_likes_ids.where(match: true)
  end

  def new
    @like = Like.new
  end

  def create
    @pet = Pet.find(params['pet_id'])
    @like = Like.new(liker_id: current_pet.id, liked_id: @pet.id)

    if @like.save!
      flash[:notice] = "J\'adore!"
      redirect_to pets_path
    end

  end

  def update
    @pet = Pet.find(params['pet_id'])
    @like = Like.find(params['id'])
    @like.update(match: true)
    flash.now[:notice] = "C\'est un match!"
    respond_to do |format|
      format.html { redirect_back fallback_location: request.referrer, notice: 'C\'est un match!'}
      format.json { }
    end
  end

  def destroy
    @pet = Pet.find(params['pet_id'])
    @my_likes_ids = current_pet.liker_likes.all
    @unliked = @my_likes_ids.where(liked: @pet)
    # already_liked() and unmatch() are defined in application_controller.rb
    if already_liked(current_pet, @pet)
      unmatch(current_pet, @pet)
    end
    @unliked.destroy
  end

  def current_pet
    current_pet = Pet.find(current_user.default_pet_id)
  end

  def already_liked(current_pet, other_pet)
    return current_pet.liked_likes.where(liker_id: other_pet).exists?
  end

  def matches_back(current_pet, other_pet)
    back_like = current_pet.liked_likes.where(liker_id: other_pet)
    back_like.update(match: true)
  end

  def unmatch(current_pet, other_pet)
    iam_liked_ids = current_pet.liked_likes.all
    unmatched = iam_liked_ids.where(liker: other_pet)
    unmatched.match = false
  end

end
