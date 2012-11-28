class UsersController < ApplicationController
  before_filter :signed_in_user, :except => [:new, :create]
  before_filter :correct_user_or_admin_user, :only => [:show, :edit, :update]
  before_filter :has_clearance, :only => [:edit, :update]
  before_filter :admin_user, :only => [:index]
  
  def index
      @users = User.all(:order => "last")
  end

  def show
    create_sections
    render :action => :edit
  end

  def new
    create_sections
    if signed_in?
      flash.now[:info] = "You are logged in as #{current_user.full_name}.
      You may use the form below to register another user."
    end
  end

  def edit
    create_sections
  end

  def create
    role = :admin

    # Remove clearance level for unprivileged users
    unless current_user && current_user.has_clearance_over(params[:user])
      params[:user].delete(:clearance_level)
      role = :default
    end

    @user = User.new(params[:user], :as => role)
    @address = @user.addresses.build(params[:address])
    @email = @user.emails.build(params[:email])
    @phone = @user.phones.build(params[:phone])
    @user.site = Site.find_by_name(params[:user][:registered_at])

    # TODO Move this logic into the model, so empty entries are not saved

    if build_optionals?(params[:work_history])
        @work_history = @user.work_histories.build(params[:work_history])
    else
        @work_history = WorkHistory.new # just discard it - NOT SAVED!
    end

    if build_optionals?(params[:work_history])
        @education = @user.educations.build(params[:education])
    else
        @education = Education.new # just discard it - NOT SAVED!
    end

    if @user.save
        flash[:success] = "Thank you for signing up with Pittsburgh CONNECTS!"
        sign_in @user
        redirect_to user_path(@user)
    else
        person_error @user
        render :new
    end
  end

  def update
    create_sections
    role = current_user.has_clearance_over(@user) ? :admin : :default

    Rails.logger.info "Update ctrl: #{@user.user_name}"

    # Must go through all associations update to collection complete errors
    success = @education.update_attributes(params[:education])
    success = @work_history.update_attributes(params[:work_history]) and success
    success = @phone.update_attributes(params[:phone]) and success
    success = @email.update_attributes(params[:email]) and success
    success = @address.update_attributes(params[:address]) and success
    success = @user.update_attributes(params[:user], :as => role) and success

    if success
      flash[:success] = "Your information has been updated!"
      redirect_to user_path(@user)
    else
      person_error @user
      render :edit
    end
  end

  def sign_up!(event)
  end

private
  # Parse through the optional fields in the form (work history, education,
  # etc.) and decide whether to create new entries for each model.
  # For example, blank work history field won't create a blank work history
  # entry

  # TODO move logic into 
  def build_optionals?(opt)
      opt.each do |attr, value|
          return true unless value.blank?
      end

      return false
  end

  def create_sections
      @user = params[:id] ? User.find(params[:id]) : User.new
      @address = @user.addresses.last || @user.addresses.new
      @email = @user.emails.last || @user.emails.new
      @phone = @user.phones.last || @user.phones.new
      @work_history = @user.work_histories.last || @user.work_histories.new
      @education = @user.educations.last || @user.educations.new
  end

end
