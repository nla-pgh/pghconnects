class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def form_requirement_notice
    flash.now[:info] = "Please fill in the fields below. Those marked with * are <strong>required</strong>!"
  end

  def person_error (user)
    flash.now[:error] = "Please correct the highlighted errors below."
  end
end
