class ApplicationController < ActionController::Base
  protect_from_forgery

	def form_requirement_notice
		flash.now[:info] = "Please fill in the fields below. Those marked with * are <strong>required</strong>!"
	end

	def person_error (user)
		flash.now[:error] = " Please fix the errors below to proceed.  
											Thank you#{", <strong>#{user.first}</strong>" if not user.first.blank? }!"
	end
end
