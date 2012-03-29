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
