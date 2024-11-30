class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You are not authorized to access this page."
    redirect_to root_path # Or redirect to the appropriate path
  end
end
