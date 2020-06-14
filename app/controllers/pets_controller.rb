class PetsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create,:edit,:destroy, :delete_photo]

  def index
    if current_user.default_pet_id.nil?
      p current_user.default_pet_id.nil?
      flash[:error] = "Vous devez ajouter un animal pour accéder à cette partie du site !"
      redirect_to root_path
    else
      @current_pet = Pet.find(current_user.default_pet_id)
      @pets_list = Pet.all.where.not(user_id: current_user.id).where(animal: @current_pet.animal.downcase)
      #@pets_list.each.select do |p| p.likes_as_liked.where.not(liker_id: @current_pet.id) end
      #return @pets_list
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    current_user.pets << @pet
    if current_user.default_pet_id.nil?
      current_user.update(default_pet_id: @pet.id)
    end
    respond_to do |format|
      if @pet.save!
        user_default_pet(current_user, @pet)
        flash[:success] = "Le profil de l'animal a bien été créé."
        format.html { redirect_to pets_path }
        format.json { }
      else
        flash[:error] = "Le profil de l'animal n'a pas été créé."
        format.html { render :new }
        format.json { }
      end
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: "Le profil de l'animal a bien été édité."}
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    if current_user.pets.empty?
      current_user.update(default_pet_id: nil)
      flash[:alert] = "Tu n'as plus aucun profil d'animaux."
      redirect_to users_path
    else
      redirect_to pets_url
    end
  end

  def user_default_pet(current_user, pet)
    if current_user.default_pet_id.nil?
      current_user.update(default_pet_id: pet.id)
    end
  end

  def delete_photo
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.purge
    redirect_back(fallback_location: request.referrer)
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :animal, :breed, :sex, :age, :user, :description, photos: [])
    end
end
