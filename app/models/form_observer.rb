class FormObserver < ActiveRecord::Observer
	observe :user, :address, :email, :event, :sign_up, :work_history,
					:education, :site, :phone

	def before_validation(model)
		strip_whitespaces(model)
	end

	private
		def strip_whitespaces(model)
			model.attributes.each do |attribute, value|
				model[attribute] = value.strip if value.respond_to?(:strip)
			end
		end
end
