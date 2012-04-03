class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @address = @user.addresses.last
    @email = @user.emails.last
    @phone = @user.phones.last
    
    wh = @user.work_histories.last
    @work_history = wh ? wh : @user.work_histories.new

    edu = @user.educations.last
    @education = edu ? edu : @user.educations.new
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

      @user.update_attributes({:user_name => generate_user_name}, :as => :admin)

      # Convert full email and phone to it's parts
      @email.regex_full
      @phone.regex_full

      # Associate the user to an ALREADY, REGISTERED site
      @user.update_attribute(:site_id, Site.find_by_name(params[:user][:registered_at]))

			# Save optional models if user filled (some) fields
			@user.work_histories << @work_history if build_optionals(@work_history)
			@user.educations << @education if build_optionals(@education)

			session[:user] = @user

      redirect_to registered_path
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
    def base_user_name
      "#{params[:user][:first].downcase[0,1]}#{params[:user][:last].downcase}_"
    end

    def generate_user_name
      size = User.count(:user_name, :conditions => "user_name LIKE '#{base_user_name}%'")
      "#{base_user_name}#{size}"
    end

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
