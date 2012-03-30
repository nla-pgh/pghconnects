# == Schema Information
#
# Table name: educations
#
#  id              :integer         not null, primary key
#  institution     :text
#  focus           :text
#  credential      :string(255)
#  school_id       :string(255)
#  finish_on       :date
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_id         :integer         not null
#  education_level :string(255)
#

class Education < ActiveRecord::Base
    attr_accessible :institution, :focus, :credential, :school_id, :finish_on, :education_level

	validates :user_id, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
	belongs_to :user
end
