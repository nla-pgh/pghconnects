class SessionsController < ApplicationController

  def create
    user = User.find_by_user_name(params[:session][:user_name])
    
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome back, #{user.full_name}!"
      sign_in user
      redirect_to user
    else
      flash[:error] = "Sign in Failed.  Please make sure that your username and password are correct"
      redirect_to :back
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
