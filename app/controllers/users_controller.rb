class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
<<<<<<< HEAD
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success]="Bravo ! Ton profil à correctement été mis à jour."
      redirect_to root_path
    else
      flash[:error]="Mince, il y a eu une erreur"
      redirect_to root_path
    end
  end

 
  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :default_pet_id)
  end
=======
  end
  
>>>>>>> development
end
