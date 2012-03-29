# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  first            :string(255)     not null
#  middle           :string(255)
#  last             :string(255)     not null
#  birth_date       :date            not null
#  registered_at    :string(255)     not null
#  gender           :string(255)
#  ethnicity        :string(255)
#  household_number :integer         not null
#  household_income :float           not null
#  education_level  :string(255)     not null
#  clearance_level  :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_name        :string(255)     not null
#  site_id          :integer         not null
#

class User < ActiveRecord::Base
	attr_protected :clearance
	attr_protected :user_name, :as => :admin

  attr_accessible :first
  attr_accessible :middle
  attr_accessible :last
  attr_accessible :birth_date
  attr_accessible :registered_at
  attr_accessible :gender
  attr_accessible :ethnicity

	validates :first, :presence => true
	validates :last, :presence => true
	validates :birth_date, :presence => true
	validates :registered_at, :presence => true
	validates :household_number, :presence => true, :numericality => { :greater_than => 0 }
	validates :household_income, :presence => true, :numericality => { :greater_than_or_equal_to => 0.0 }
	validates :education_level, :presence => true
	validates :clearance_level, :presence => true
	validates :user_name, :presence => true
	
	belongs_to :site
	has_many :addresses, :dependent => :destroy
	has_many :phones, :dependent => :destroy
	has_many :emails, :dependent => :destroy
	has_many :educations, :dependent => :destroy
	has_many :work_histories, :dependent => :destroy
	has_many :sign_ups, :group => :event_id, :order => :site_id
	has_many :events, :through => :sign_ups, :group => :site_id
end
