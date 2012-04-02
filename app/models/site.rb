# == Schema Information
#
# Table name: sites
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  address    :string(255)     not null
#  phone      :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  abbr       :string(255)
#  base_ip    :string(255)
#

class Site < ActiveRecord::Base
    attr_accessible :name, :address, :phone, :abbr, :base_ip, :as => :admin
    attr_accessible :name, :address, :phone, :abbr, :base_ip

	validates :name, :presence => true
	validates :address, :presence => true
    validates :phone, :format => { :with => Phone::VALID_PHONE_REGEX, :message => "should be formatted as 123-123-1234" }
    validates :base_ip, :numericality => true, :format => { :with => /\A\d+.\d+\z/ }

	has_many :users, :dependent => :destroy, :order =>  :last
	has_many :coordinators, :class_name => "User", :conditions => { :clearance_level => "C" }, :dependent => :destroy

	has_and_belongs_to_many :events

	has_one :manager, :class_name => "User", :conditions => { :clearance_level => "M" }, :dependent => :destroy
end
