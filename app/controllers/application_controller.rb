class ApplicationController < ActionController::Base
  include UsersHelper
  include PetsHelper

  def after_sign_in_path_for(resource)
    pets_path
  end

end
