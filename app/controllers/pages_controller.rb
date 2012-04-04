class PagesController < ApplicationController
  def index
      flash.clear
  end

	def sign_in
		@user = User.new
	end
end
