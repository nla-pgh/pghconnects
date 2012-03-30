# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  first           :string(255)     not null
#  middle          :string(255)
#  last            :string(255)     not null
#  birth_date      :date            not null
#  registered_at   :string(255)     not null
#  gender          :string(255)
#  ethnicity       :string(255)
#  clearance_level :string(255)     default("U"), not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_name       :string(255)
#  site_id         :integer
#

class User < ActiveRecord::Base
	attr_accessible :first, :middle, :last, :birth_date, :registered_at, :gender, :ethnicity, :user_name, :clearance_level, :as => :admin

    attr_accessible :first, :middle, :last, :birth_date, :registered_at, :gender, :ethnicity

	validates :first, :presence => true
	validates :last, :presence => true
	validates :birth_date, :presence => true
	validates :registered_at, :presence => true
  validates :user_name, :uniqueness => { :allow_nil => true, :allow_blank => true }
	
	belongs_to :site
	has_many :addresses, :dependent => :destroy
	has_many :phones, :dependent => :destroy
	has_many :emails, :dependent => :destroy
	has_many :educations, :dependent => :destroy
	has_many :work_histories, :dependent => :destroy
	has_many :sign_ups, :group => :event_id, :order => :site_id, :dependent => :destroy
	has_many :events, :through => :sign_ups, :group => :site_id, :dependent => :destroy
end
