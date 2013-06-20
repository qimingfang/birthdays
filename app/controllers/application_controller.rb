class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:current_user]) if session[:current_user]
  end

end
