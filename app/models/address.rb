# == Schema Information
#
# Table name: addresses
#
#  id               :integer         not null, primary key
#  number           :integer         not null
#  street           :string(255)     not null
#  apt_fl           :string(255)
#  city             :string(255)     not null
#  state            :string(255)     not null
#  zip              :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_id          :integer
#  household_number :integer         not null
#  household_income :float           not null
#

class Address < ActiveRecord::Base
  attr_accessible :number, :street, :apt_fl, :city, :state, :zip, :household_number, :household_income, :as => :admin

  attr_accessible :number, :street, :apt_fl, :city, :state, :zip, :household_number, :household_income

  validates :number,  :presence => true,  :numericality => { :greater_than => 0 }
  validates :street,  :presence => true, :format => { :with => %r_([a-zA-Z]+)\s+([a-zA-Z]{2,6})_, :message => "should be in the format: Penn Ave" }# street must be in the format of XXXXX XXXXX
  validates :city,    :presence => true
  validates :state,   :presence => true, :length => { :is => 2 }
  validates :zip,     :presence => true,
                      :length => { :is => 5 },
                      :numericality => { :greater_than => 0 }

  validates :household_number, :numericality => { :greater_than_or_equal_to => 0, :allow_blank => true, :allow_nil => true }
  validates :household_income, :numericality => { :greater_than_or_equal_to => 0.0, :allow_blank => true, :allow_nil => true }

  belongs_to :user

    def full_address
        "#{number} #{street} #{"APT/FL #{apt_fl}" unless apt_fl.blank?}, #{city}, #{state} #{zip}" unless new_record?
    end
end
