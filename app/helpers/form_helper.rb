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
end
