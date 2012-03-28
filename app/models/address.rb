# == Schema Information
#
# Table name: addresses
#
#  id         :integer         not null, primary key
#  number     :integer         not null
#  street     :string(255)     not null
#  apt_fl     :string(255)
#  city       :string(255)     not null
#  state      :string(255)     not null
#  zip        :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Address < ActiveRecord::Base
    validates :number,  :presence => true,  :numericality => true
    validates :street,  :presence => true, :format => { :with => %r_([a-zA-Z]+)\s+([a-zA-Z]{3,6})_ }# street must be in the format of XXXXX XXXXX
    validates :apt_fl,  :numericality => true, :allow_blank => true
    validates :city,    :presence => true
    validates :state,   :presence => true, :length => { :is => 2 }
    validates :zip,     :presence => true,
                        :length => { :is => 5 },
                        :numericality => true

		belongs_to :user
end
