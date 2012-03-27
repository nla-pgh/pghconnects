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
#  user_name        :string(255)     indexed
#

class User < ActiveRecord::Base
	attr_protected :clearance
	attr_protected :user_name, :as => :admin

	validates :first, :presence => true
	validates :last, :presence => true
	validates :birth_date, :presence => true
	validates :registered_at, :presence => true
	validates :household_number, :presence => true, :numericality => { :greater_than => 0 }
	validates :household_income, :presence => true, :numericality => { :greater_than_or_equal_to => 0.0 }
	validates :education_level, :presence => true
	validates :clearance_level, :presence => true
	validates :user_name, :presence => true
end
