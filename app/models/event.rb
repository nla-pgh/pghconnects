# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  start       :datetime        not null
#  end         :datetime        not null
#  description :text            not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Event < ActiveRecord::Base
	validates :name, :presence => true
	validates :start, :presence => true
	validates :end, :presence => true
	validates :description, :presence => true
end
