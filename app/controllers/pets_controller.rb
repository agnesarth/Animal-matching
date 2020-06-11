class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:edit,:destroy, :delete_photo]


  def index
    @pets = Pet.all
  end


  def new
    @pet = Pet.new
  end


  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    # user_default_pet() defined in application_controller as first pet created
    user_default_pet(current_user, @pet)

    respond_to do |format|
      if @pet.save!
        flash[:success] = 'Animal bien ajouté!'
        format.html { redirect_to pets_path }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_default_pet(current_user, @pet)
    if current_user.default_pet_id.nil?
      current_user.update(default_pet_id: @pet.id)
    end
  end

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
      params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age, :user_id, photos: [])
    end
end
