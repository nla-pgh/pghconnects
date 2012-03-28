# == Schema Information
#
# Table name: educations
#
#  id          :integer         not null, primary key
#  institution :text
#  focus       :text
#  credential  :string(255)
#  school_id   :string(255)
#  finish_on   :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Education < ActiveRecord::Base
end
