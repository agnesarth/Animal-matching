class TagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tag = Tag.new()
  end

  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save!
        flash[:success] = "Le tag a bien été créé."
        format.html { redirect_to tags_path }
        format.json { }
      else
        flash[:error] = "Erreur : Le tag n'a pas été créé."
        format.html { render :new }
        format.json { }
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      flash[:info] = "Le tag a bien été supprimé"
      redirect_to root_path
    else
      flash[:error] = "Erreur : Le tag n'a pas été supprimé"
      redirect_to root_path
    end
  end

  private
    def tag_params
      params.require(:tag).permit(:id, :value)
    end
end
