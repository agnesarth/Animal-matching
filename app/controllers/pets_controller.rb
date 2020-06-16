class PetsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :edit, :destroy, :delete_photo]
  before_action :is_current_user?, only: [ :edit, :destroy, :delete_photo]
  before_action :is_default_pet, only: [:index, :show]

  def index
    @current_pet = Pet.find(current_user.default_pet_id)
    @pets_list = Pet.search(params[:search]).where.not(user_id: current_user.id)
    #For search in index
    @pets_species = Pet.search(params[:search]).where.not(user_id: current_user.id).where(animal: @current_pet.animal)
  end

  def new
    @pet = Pet.new
    @tag = Tag.all
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    respond_to do |format|
      if @pet.save
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
    redirect_to users_path
  end

  def delete_photo
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.purge
    redirect_back(fallback_location: request.referrer)
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :animal, :breed, :sex, :age, :user, :description, :search, photos: [], tag_ids: [])
    end

    def is_current_user?
      if current_user != Pet.find(params[:id]).user
        flash[:error] = "Vous ne pouvez pas accéder au profil de cet animal."
        redirect_to root_path
      end
    end

    def is_default_pet
      if current_user.default_pet_id.nil?
        flash[:error] = "Vous devez d'abord créer un profil animal."
        redirect_to new_pet_path
      end
    end


end
