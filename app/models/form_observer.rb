class FormObserver < ActiveRecord::Observer
	observe :user, :address, :email, :event, :sign_up, :work_history,
					:education, :site, :phone

	def before_validation(model)
		formalize_strings(model)
	end

private
    # Strip whitespaces, squeeze white spaces and '-', and upcase all characters
    def formalize_strings(model)
        ignored_attributes = %w(password_digest user_name education_level)
        model.attributes.each do |attribute, value|
            unless(ignored_attributes.include?(attribute))
              model[attribute] = value.strip.squeeze(' ').squeeze('-').upcase if value.acts_like?(:string)
            end
        end
    end
end
