class SessionsController < ApplicationController
  def create
    session[:logged_in] = User.find_or_create_by_email(auth_hash[:info][:email]).id
    session[:user_shortname] = auth_hash[:info][:first_name]
    session[:user_icon] = auth_hash[:info][:image]
    session[:user_email] = auth_hash[:info][:email]
    redirect_to controller: :editor, action: :index
  end
  
  def close
    session[:logged_in] = nil
    redirect_to controller: :editor, action: :index
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
