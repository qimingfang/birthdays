class UsersController < ApplicationController
  protect_from_forgery

  def index
    @users = User.all
  end

  def new
    client = User.auth(callback_user_url).client
    redirect_to client.authorization_uri(
      :scope => User.config[:scope]
    )
  end

  def create
    client = User.auth(callback_user_url).client
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body
    user = FbGraph::User.me(access_token).fetch
    user, is_new_user = User.identify(user)

    authenticate user
    
    session[:is_new_user] = is_new_user

    redirect_to :controller => 'Users', :action => 'index'
  end

  def destroy
    unauthenticate
    redirect_to root_url
  end
end
