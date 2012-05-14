module ApplicationHelper
    IP_REGEX = /\A(\d*\.\d*)/

    def admin?
        false
    end

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

    def sites
        Site.all(:order => "name")
    end

    def genders
        { :list => CONNECTS["form"]["gender"].sort }
    end

    def ethnicities
        { :list => CONNECTS["form"]["ethnicity"].sort }
    end

    def household_numbers
        list = CONNECTS["form"]["household_numbers"]

        label = Proc.new do |num|
            if num.nonzero?
                num.to_s
            else
                 "More than #{list.max}"
            end
        end

        { :list => list, :label => label}
    end

    def household_incomes
        list = CONNECTS["form"]["household_incomes"]

        prev = 0
        label = Proc.new do |num|
            if num.nonzero?
                s = "#{number_to_currency(prev)} - #{number_to_currency(num)}"
                prev = num
                s
            else
                "More than #{number_to_currency(list.max)}"
            end
        end

        { :list => list, :label => label }
    end

    def education_levels
        list = CONNECTS["form"]["education_levels"]

        label = Proc.new do |v|
            v
        end
        
        value = Proc.new do |v|
            v.upcase
        end

        { :list => list, :label => label, :value => value }
    end

    def clearance_levels
        list = CONNECTS["form"]["clearance_levels"].sort

        label = Proc.new do |v|
            v
        end

        value = Proc.new do |v|
            v[0,1]
        end

        { :list => list, :label => label, :value => value }
    end

    def site_users(user)
    end

    def year
        Date.today.year
    end
end
