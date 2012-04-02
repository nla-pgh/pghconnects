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
#  user_id     :integer
#

class WorkHistory < ActiveRecord::Base
    attr_accessible :start, :end, :description, :title, :business, :as => :admin
    attr_accessible :start, :end, :description, :title, :business

	belongs_to :user
end
