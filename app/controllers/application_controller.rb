class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    categories_path # or wherever you want to redirect users after they sign in
  end
end
