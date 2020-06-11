class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :create,:edit,:destroy, :delete_photo]


  def index
    @current_pet = Pet.find(current_user.default_pet_id)
    @pets_list = Pet.all.where.not(id: @current_pet.id, sex: @current_pet.sex).where(animal: @current_pet.animal)
    @iam_liked_ids = @current_pet.liked_likes
  end


  def new
    @pet = Pet.new
  end


  def create
    @pet = Pet.create(user: current_user)
    @pet.update(pet_params)
    #current_user.pets << @pet
    if current_user.default_pet_id.nil?
      current_user.update(default_pet_id: @pet.id)
    end

    respond_to do |format|
      if @pet.save!
        flash[:success] = 'Animal bien ajouté!'
        format.html { redirect_to pets_path }
        format.json { }
      end
    end
  end

  #def user_default_pet(current_user,pet)
    #if user.default_pet_id.nil?
      #user.update(default_pet_id: pet.id)
    #end
  #end

  def show
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def delete_photo
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.purge
    redirect_back(fallback_location: request.referrer)
  end

  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Tes modifications ont bien été sauveguardées, miao!'}
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: "Profil de #{@pet.name} supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  private

    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age, :user, photos: [])
    end

    #def current_pet
      #@pet = Pet.find(current_user.default_pet_id)
    #end
end
