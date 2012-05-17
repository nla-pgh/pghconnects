module FormHelper
    # Hash for simple form input for :registered_at
    def site_hash
        {   
            :label => "Registration Site",
            :collection => sites,
            :value_method => Proc.new { |v| v },
            :include_blank => false,
            :selected => ip_to_name
        }
    end

    # Hash for simple form input for :clearance
    def clearance_hash
        {
            :collection => clearance_levels[:list],
            :label => "Clearance",
            :value_method => clearance_levels[:value],
            :label_method => clearance_levels[:label],
            :include_blank => false,
            :selected => @user.clearance_level
        }
    end

    def sites
        Site.all(:order => "name")
    end

    def genders
        { :list => CONNECTS[:form][:gender].sort }
    end

    def ethnicities
        { :list => CONNECTS[:form][:ethnicity].sort }
    end

    def household_numbers
        list = CONNECTS[:form][:household_numbers]

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
        list = CONNECTS[:form][:household_incomes]

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
        list = CONNECTS[:form][:education_levels]

        label = Proc.new do |v|
            v
        end
        
        value = Proc.new do |v|
            v.upcase
        end

        { :list => list, :label => label, :value => value }
    end

    def clearance_levels
        list = CONNECTS[:form][:clearance_levels].sort

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
