namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		2000.times do |n|
			first = Faker::Name.first_name
			last = Faker::Name.last_name
			birth_date = Date.today
			registered_at = CONNECTS["sites"][n % 4][:name]
			gender = CONNECTS["form"]["gender"].values[n % 3]
			ethnicity = CONNECTS["form"]["ethnicity"].values[n % 7]
			password = password_confirmation = 'password'
			
			User.create!(:first => first, :last => last, :birth_date => birth_date,
									 :registered_at => registered_at, :gender => gender,
									 :ethnicity => ethnicity, :password => password,
									 :password_confirmation => password)
		end
	end
end
