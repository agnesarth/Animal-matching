class LikesController < ApplicationController
  before_action :current_pet, only: [:create,:update,:destroy]

  def index
    @my_likes = Like.where(match: false,liker_id: current_pet.id)
    @my_search = get_pets(@my_likes) & Pet.search(params[:search]) & Pet.where.not(user_id: current_user.id)
    @my_matches = Like.where(match: true,liker_id: current_pet.id)
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
        if already_liked?(@like)
          chatroom_match!(@like, @pet)
        end
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

  def already_liked?(like)
    liker_pet = Pet.find(like.liked_id)
    liked_pet = Pet.find(like.liker_id)
    return Like.where(liked_id: liked_pet.id, liker_id: liker_pet.id).exists?
  end

  def chatroom_match!(like, pet)
      @title = "#{Pet.find(like.liked_id).name} et #{Pet.find(like.liker_id).name}"
      @chatroom = Chatroom.new
      @chatroom = current_user.chatrooms.build(title: @title)
      @chatroom.users << current_user
      @chatroom.users << pet.user
      @chatroom.save
  end

  def get_pets(likes)
    search_likes = []
    likes.each do |like|
      search_likes << Pet.find(like.liked_id)
    end
    return search_likes

  end

end
