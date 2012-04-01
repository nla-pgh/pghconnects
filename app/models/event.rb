# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  start       :datetime        not null
#  end         :datetime        not null
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Event < ActiveRecord::Base
    attr_accessible :name, :start, :end, :description

	validates :name, :presence => true
	validates :start, :presence => true
	validates :end, :presence => true

	has_and_belongs_to_many :sites
	has_many :sign_ups
	has_many :users, :through => :sign_ups
	has_many :attendents, :class_name  => "User", :conditions => { :attended => true }
end
