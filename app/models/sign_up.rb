# == Schema Information
#
# Table name: sign_ups
#
#  id         :integer         not null, primary key
#  attended   :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  event_id   :integer         not null
#  user_id    :integer         not null
#

class SignUp < ActiveRecord::Base
    attr_accessible :attended

	validates :attended, :inclusion => { :in => [false, true] }
	validates :event_id, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :user_id, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
	belongs_to :event
	belongs_to :user
end
