class ApplicationController < ActionController::Base
  include UsersHelper
  include PetsHelper

  def after_sign_in_path_for(resource)
    root_path
  end

end
