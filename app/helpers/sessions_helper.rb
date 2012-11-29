module SessionsHelper

  DENIED_MSG = "Access denied. You do not have the privilege to access the page. Please login if you have not already done so."

  def sign_in(user)
    session[:remember_token] = user.id
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:remember_token]) if session[:remember_token]
  end

  def sign_out
    session.delete(:remember_token)
    @current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def admin?
    # Administrator = clearance_level of 'C', 'M', or 'S'
    signed_in? && current_user.admin?
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_path, :notice => DENIED_MSG
    end
  end

  def correct_user
    user = User.find(params[:id])
    unless current_user?(user)
      store_location
      redirect_to root_path, :notice => DENIED_MSG
    end
  end

  def admin_user
    unless admin?
      store_location
      redirect_to root_path, :notice => DENIED_MSG
    end
  end

  def correct_user_or_admin_user
    user = User.find(params[:id])
    unless current_user?(user) or admin?
      store_location
      redirect_to root_path, :notice => DENIED_MSG
    end
  end

  def has_clearance
    user = User.find(params[:id])
    unless current_user.has_clearance_over(user)
      store_location
      redirect_to root_path, :notice => DENIED_MSG
    end
  end

  def manager?
    signed_in? && current_user.manager?
  end

  def super?
    signed_in? && current_user.super?
  end

private
  def current_user=(user)
    @current_user = user
  end
end
