class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy, :upload_photo, :delete_photo]


  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.all
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)

    respond_to do |format|
      if @pet.save!
        flash[:success] = 'Animal bien ajouté!'
        format.html { redirect_back(fallback_location: request.referrer) }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_photo
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.purge
    redirect_back(fallback_location: pet_path(@pet.id))
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
  end

  # GET /pets/1/edit
  def edit
    @pet = Pet.find(params[:id])
  end

  def delete_photo
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.purge
    redirect_back(fallback_location: pet_path(@pet.id))
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        flash[:notice] = 'Tes modifications ont bien été suaveguardées, miao!'
        format.html { redirect_to @pet }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: "Profil de #{@pet.name} supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :animal, :chip_number, :breed, :sex, :age, photos: [])
    end
end
