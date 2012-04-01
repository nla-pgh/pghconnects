class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    form_requirement_notice
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "User successfully created, please fill in additional information to receive login information"

      @user.update_attributes({:user_name => generate_user_name}, :as => :admin)
      
      # Associate the user to an already, registered site
      @user.site = Site.find_by_name(params[:registered_at])
      
      session[:user] = @user
      redirect_to new_user_address_path(@user)
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end


  private
    def base_user_name
      "#{params[:user][:first].downcase[0,1]}#{params[:user][:last].downcase}_"
    end

    def generate_user_name
      size = User.count(:user_name, :conditions => "user_name LIKE '#{base_user_name}%'")
      "#{base_user_name}#{size}"
    end
end
