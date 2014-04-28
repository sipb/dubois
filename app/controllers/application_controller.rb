class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :sign_in_for_development, :if => lambda { Rails.env.development? }

  private

    def require_current_user!
      sign_in_for_development
      render :controller => :sessions, :action => :new if current_user.nil?
    end

    def current_user
      return nil if session[:email].blank?
      @user ||= User.where("lower(email) = ?", session[:email].downcase).first
    end

    def sign_in_for_development
      session[:email] = "lfaraone@mit.edu"
    end

    helper_method :current_user

end
