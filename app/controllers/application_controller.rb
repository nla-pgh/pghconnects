class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

	def form_requirement_notice
		flash.now[:info] = "Please fill in the fields below. Those marked with * are <strong>required</strong>!"
	end

	def person_error (user)
		flash.now[:error] = " Please fix the errors below to proceed.  
											Thank you#{", <strong>#{user.first}</strong>" if not user.first.blank? }!"
	end

    def flash_success(user)
        flash[:success] = <<-END
            Thank you, <strong>#{@user.first}</strong> for registering with Pittsburgh CONNECTS! To receive your login information, please fill in the remaining information."
            END
    end

protected
end
