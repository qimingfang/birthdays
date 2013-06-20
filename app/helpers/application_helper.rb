module ApplicationHelper
  def authenticate(user)
    raise Unauthorized unless user
    session[:current_user] = user.id
  end
  def unauthenicate
    session[:current_uesr] = nil
  end
end
