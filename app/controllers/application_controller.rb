class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login
  layout :determine_layout

  def not_authenticated
    flash[:alert] = "First login to access this page" unless request.fullpath == root_path
    redirect_to login_url
  end

  private
  def determine_layout
    current_user ? "application" : "login"
  end
end
