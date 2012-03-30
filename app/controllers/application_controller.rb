class ApplicationController < ActionController::Base
  protect_from_forgery

	def form_requirement_notice
		flash[:info] = "Please fill in the fields below. Those marked with * are <strong>required</strong>!"
	end
end
