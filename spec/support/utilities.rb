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
		:user_name => Faker::Internet.user_name,
		:clearance_level => "U"
	}

    attrs[attr] = value if attr

	user = User.new
    user.assign_attributes(attrs, :without_protection => true)
    return user
end

def factory_address(attr, value)
	attrs = {
		:number => 5429,
		:street => "#{Faker::Address.street_name} #{Faker::Address.street_suffix}",
		:apt_fl => 1,
		:city => Faker::Address.city,
		:state => Faker::Address.us_state_abbr,
		:zip => Faker::Address.zip_code[0,5],
        :household_number => 1,
        :household_income => 1.0
	}

	attrs[attr] = value if attr

    address = Address.new
    address.assign_attributes(attrs, :without_protection => true)
    return address
end

def factory_phone(attr, value)
    attrs = { :area => '412', :carrier => '456', :line => '7890' }

    attrs[attr] = value if attr
    phone = Phone.new
    phone.assign_attributes(attrs, :without_protection => true)
    return phone
end

def factory_email(attr, value)
    attrs = { :address => "dkm", :domain => "fake", :root => "com" }

    attrs[attr] = value if attr
    email = Email.new
    email.assign_attributes(attrs, :without_protection => true)
    return email
end

def factory_edu(attr, value) 
    attrs = {   :institution => "Carneige Mellon University",
                :focus => "Computer Science",
                :credential => "Bachelor of Science",
                :school_id => '',
                :finish_on => Date.today
            }

    attrs[attr] = value if attr

    edu = Education.new
    edu.assign_attributes(attrs, :without_protection => true)
    return edu
end

def factory_site(attr, value)
	attrs = { :name => "NLA", :address => "5429 Penn Ave", :phone => "412-123-4556" }

	attrs[attr] = value if attr
	site = Site.new
    site.assign_attributes(attrs, :without_protection => true)
    return site
end

def factory_event(attr, value)
	attrs = { :name => "Event", :start => DateTime.yesterday, :end => DateTime.now, :description => "A Test Event" }

	attrs[attr] = value if attr
    event = Event.new
    event.assign_attributes(attrs, :without_protection => true)
    return event
end

def factory_signup(attr, value)
	attrs = { :attended => false, :event_id => 0, :user_id => 0 }
	attrs[attr] = value if attr
	sign_up = SignUp.new
    sign_up.assign_attributes(attrs, :without_protection => true)
    return sign_up
end
