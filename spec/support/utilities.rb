require 'active_support/inflector'
require 'faker'

def factory (model, attrs)
	eval("#{model.to_s.camelize}.new(attrs)") if ActiveRecord::Base.connection.table_exists? model.to_s.pluralize
end

def factory_user(attr, value)
	attrs = { 
		:first => Faker::Name.first_name,
		:last => Faker::Name.last_name,
		:birth_date => Date.today,
		:registered_at => "BGC",
		:gender => "Female",
		:ethnicity => "Black",
		:household_number => 3,
		:household_income => 100000.00,
		:education_level => "college",
		:user_name => Faker::Internet.user_name,
		:clearance_level => "user"
	}

	if attr 
		attrs[attr] = value
	end

	User.new(attrs)
end
