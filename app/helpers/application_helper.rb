module ApplicationHelper
  IP_REGEX = /\A(\d*\.\d*)/

  def offsite?
      Site.all.each do |site|
          return false if site[:name] == ip_to_name
      end

      true
  end

  def ip_to_name
    client_ip = request.remote_ip
    match = IP_REGEX.match(client_ip)[1]

    Site.all.each do |site|
        return site[:name] if site[:base_ip] == match.to_s
    end

    match
  end

  def all_sites
      names = []

      Site.all(:order => "name").each do |site|
          names << site.name
      end

      names
  end

  def all_genders
      CONNECTS["form"]["gender"].sort
  end

  def all_ethnicities
      CONNECTS["form"]["ethnicity"].sort
  end

  def all_household_numbers
      arr = CONNECTS["form"]["household_numbers"]
      
      label = Proc.new do |num|
         if num.nonzero?
             num.to_s 
         else
             "More than #{arr.max}"
         end
      end

      [arr, label]
  end

  def all_household_incomes
      arr = CONNECTS["form"]["household_incomes"]
      
      label = Proc.new do |num|
          if num.nonzero?
              number_to_currency(num)
          else
              "More than #{number_to_currency(arr.max)}"
          end
      end

      [arr, label]
  end

	def all_education_levels
		arr = CONNECTS["form"]["education_levels"]

		label = Proc.new do |v|
			v
		end

		[arr, label]
	end
end
