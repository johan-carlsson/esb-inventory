class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize, only: [:edit, :update,:new,:create,:destroy]
  include Userstamp

  def authorize
   redirect_to :back, notice: "Not authorized" if current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  hide_action :current_user

end

