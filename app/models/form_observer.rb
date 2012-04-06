class FormObserver < ActiveRecord::Observer
	observe :user, :address, :email, :event, :sign_up, :work_history,
					:education, :site, :phone

	def before_validation(model)
		formalize_strings(model)
	end

	private
		# Strip whitespaces, squeeze white spaces and '-', and upcase all characters
		def formalize_strings(model)
			model.attributes.each do |attribute, value|
        unless(attribute == "password_digest" || attribute == "user_name")
          model[attribute] = value.strip.squeeze(' ').squeeze('-').upcase if value.acts_like?(:string)
        end
			end
		end
end
