class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    form_requirement_notice
    @user = User.new
    @address = @user.addresses.new
    @email = @user.emails.new
    @phone = @user.phones.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    @address = @user.addresses.build(params[:address])
    @email = @user.emails.build(params[:email])
    @phone = @user.phones.build(params[:phone])

    if @user.save
      flash[:success] = "Thank you, <strong>#{@user.first}</strong> for registering with Pittsburgh CONNECTS! To receive your login information, please fill in the remaining forms."

      @user.update_attributes({:user_name => generate_user_name}, :as => :admin)

      # Convert full email and phone to it's parts
      @email.regex_full
      @phone.regex_full

      # Associate the user to an ALREADY, REGISTERED site
      @user.site = Site.find_by_name(params[:registered_at])
      
      redirect_to new_user_address_path(@user)
    else
        person_error @user
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
