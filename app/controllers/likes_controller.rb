class LikesController < ApplicationController
  before_action :current_pet, only: [:create,:update,:destroy]

  def index
    @my_likes = []
    Like.where(match: false,liker_id: current_pet.id).each do |l| @my_likes << Pet.find(l.liked_id) end
    @my_matches = []
    Like.where(match: true,liker_id: current_pet.id).each do |l| @my_matches << Pet.find(l.liked_id) end
    Like.where(match: true,liked_id: current_pet.id).each do |l| @my_matches << Pet.find(l.liker_id) end
  end

  def show
    #array containing all likes from the current_pet
    #@my_likes_ids = current_pet.likes_as_liker.all
    #array containing all likes towards the current_pet
    #@iam_liked_ids = current_pet.likes_as_liked.all
    @my_matches = @my_likes_ids.where(match: true)
  end

  def new
    @like = Like.new
  end

  def create
    @pet = Pet.find(params['pet_id'])
    @like = Like.new(liker_id: current_pet.id, liked_id: @pet.id)
    respond_to do |format|
      if @like.save!
        format.html { redirect_to pets_path, notice: 'J\'adore!' }
        format.js { }
      end
    end
  end

  def update
    @pet = Pet.find(params['pet_id'])
    @like = Like.find(params['id'])
    @like.update(match: true)
    respond_to do |format|
      format.html { redirect_back fallback_location: request.referrer, notice: "C'est un match!"}
      format.js { }
    end
  end

  def destroy
    @pet = Pet.find(params['pet_id'])
    @my_likes_ids = current_pet.liker_likes.all
    @unliked = @my_likes_ids.where(liked: @pet)
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
    iam_liked_ids = current_pet.likes_as_liked.all
    unmatched = iam_liked_ids.where(liker: other_pet)
    unmatched.match = false
  end
end
