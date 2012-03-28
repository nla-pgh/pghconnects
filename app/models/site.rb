# == Schema Information
#
# Table name: sites
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Site < ActiveRecord::Base
	validates :name, :presence => true
	validates :address, :presence => true
	validates :phone, :presence => true, :format => { :with => %r_\A\d{3}-\d{3}-\d{4}\Z_ }
end
