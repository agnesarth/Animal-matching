class PetsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create,:edit,:destroy, :delete_photo]


  def index
    if current_user.default_pet_id.nil?
      flash[:error] = "Vous devez d'abord enregistrer un animal!"
      redirect_to root_path
    else
      @current_pet = Pet.find(current_user.default_pet_id)
      @pets_list = Pet.all.where.not(user_id: current_user.id).where(animal: @current_pet.animal.downcase)
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user

    respond_to do |format|
      if @pet.save!
        user_default_pet(current_user, @pet)
        flash[:success] = 'Animal bien ajouté!'
        format.html { redirect_to pets_path }
        format.json { }
      end
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Tes modifications ont bien été sauvegardées, miao!'}
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
      params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age, :user, photos: [])
    end
end
