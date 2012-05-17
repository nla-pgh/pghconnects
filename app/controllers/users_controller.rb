class UsersController < ApplicationController
  def index
      # TODO Administrative authentication for indexing.
      # Only administrative users should be able to see all the users
    @user = User.first
    if @user
        @users = User.find_all_by_registered_at(@user.registered_at, :order => "last")
    else
        @users = []
    end
  end

  def show
    create_sections
  end

  def new
    form_requirement_notice
    create_sections
  end

  def edit
    create_sections
  end

  def create
    @user = User.new(params[:user])
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
        flash_success @user
        redirect_to user_path(@user)
    else
        person_error @user
        render :new
    end
  end

  def update
      create_sections

      # TODO Messy code! Should really consider improving the logic...somehow
      if @user.update_attributes(params[:user]) and @address.update_attributes(params[:address]) and @email.update_attributes(params[:email]) and @phone.update_attributes(params[:phone]) and @work_history.update_attributes(params[:work_history]) and @education.update_attributes(params[:education])

          flash_success @user
          redirect_to user_path(@user)
      else
          person_error @user
          render :edit
      end
  end

  def destroy
  end


  private
    # Parse through the optional fields in the form (work history, education,
    # etc.) and decide whether to create new entries for each model.
    # For example, blank work history field won't create a blank work history
    # entry
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
