require 'active_support/inflector'
require 'faker'

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

def factory_address(attr, value)
	attrs = {
		:number => 5429,
		:street => "#{Faker::Address.street_name} #{Faker::Address.street_suffix}",
		:apt_fl => 1,
		:city => Faker::Address.city,
		:state => Faker::Address.us_state_abbr,
		:zip => Faker::Address.zip_code
	}

	attrs[attr] = value if attr

	Address.new(attrs)
end
