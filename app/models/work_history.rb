# == Schema Information
#
# Table name: work_histories
#
#  id          :integer         not null, primary key
#  business    :string(255)
#  start       :date
#  end         :date
#  description :text
#  title       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class WorkHistory < ActiveRecord::Base
	belongs_to :user
end
