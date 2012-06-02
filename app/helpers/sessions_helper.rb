module SessionsHelper

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
    signed_in? && current_user.clearance_level != 'U'
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
      redirect_to signin_path, :notice => "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      store_location
      redirect_to(root_path)
    end
  end

  def admin_user
    unless admin?
      store_location
      redirect_to signin_path, :alert => "If you're an administrator, please sign in."
    end
  end
private
  def current_user=(user)
    @current_user = user
  end
end
