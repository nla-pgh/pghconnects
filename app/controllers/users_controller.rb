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
		@work_history = @user.work_histories.new
		@education = @user.educations.new
  end

  def edit
    @user = User.find(params[:id])
    @address = @user.addresses.last
    @email = @user.emails.last
    @phone = @user.phones.last
    
    wh = @user.work_histories.last
    @work_history = wh ? wh : @user.work_histories.new

    edu = @user.educations.last
    @education = edu ? edu : @user.educations.new
  end

  def create
    @user = User.new(params[:user])
    @address = @user.addresses.build(params[:address])
    @email = @user.emails.build(params[:email])
    @phone = @user.phones.build(params[:phone])
		@work_history = WorkHistory.new
		@education = Education.new

    if @user.save
      flash[:success] = "Thank you, <strong>#{@user.first}</strong> for registering with Pittsburgh CONNECTS! To receive your login information, please fill in the remaining forms."

      # Associate the user to an ALREADY, REGISTERED site
      @user.update_attribute(:site_id, Site.find_by_name(params[:user][:registered_at]))

			# Save optional models if user filled (some) fields
			@user.work_histories << @work_history if build_optionals(@work_history)
			@user.educations << @education if build_optionals(@education)

			session[:user] = @user.id

      redirect_to user_path(@user)
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

		def build_optionals(opt)
			save = false
			opt.class.attribute_names.each do |attr|
				if not params[attr.to_sym].blank?
					opt[attr.to_sym] = params[attr.to_sym]
					save = true
				end
			end

			save
		end
end
