# == Schema Information
#
# Table name: phones
#
#  id         :integer         not null, primary key
#  area       :string(255)
#  carrier    :string(255)
#  line       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  full       :string(255)     not null
#

class Phone < ActiveRecord::Base
    VALID_PHONE_REGEX = /\A(\d{3})-?(\d{3})-?(\d{4})\z/
    attr_accessible :area, :carrier, :line, :as => :admin
    attr_accessible :full

    validates :full, :presence => true, :format => { :with => VALID_PHONE_REGEX, :message => "should be formatted as 123-123-1234" }

    validates :area, :length => { :is => 3 }, :numericality => true, :allow_blank => true, :allow_nil => true
    validates :carrier, :length => { :is => 3 }, :numericality => true, :allow_blank => true, :allow_nil => true
    validates :line, :length => { :is => 4 }, :numericality => true, :allow_blank => true, :allow_nil => true

	belongs_to :user

    def regex_full
        match = VALID_PHONE_REGEX.match(full)

        update_attributes({:area => match[1], :carrier => match[2], :line => match[3] }, :as => :admin)
    end
end
