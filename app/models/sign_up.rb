# == Schema Information
#
# Table name: sign_ups
#
#  id         :integer         not null, primary key
#  attended   :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class SignUp < ActiveRecord::Base
	validates :attended, :inclusion => { :in => [false, true] }
	belongs_to :event
	belongs_to :user
end
