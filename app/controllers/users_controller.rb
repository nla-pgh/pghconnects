class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new(:registered_at => resolve_ip.to_s)
  end

  def edit
  end

  def create
    @user = User.new
    params[:user].each do |attr, value|
      @user[attr.to_sym] = value
    end

    if @user.save
      flash[:notice] = "User successfully created, please fill in additional information to receive login information"
      redirect_to "#{user_url}/addresses/new"
    else
      render new_user_path
    end

  end

  def update
  end

  def destroy
  end


  private
    def resolve_ip
      client_ip = request.remote_ip
      client_ip = "10.96.0.23"
      regex = /^(\d*\.\d*)/
      match = regex.match(client_ip)[1]

      if match and PGHCONNECTS["resolutions"][match.to_f]
        PGHCONNECTS["resolutions"][match.to_f]
      else
        client_ip
      end
    end
end
