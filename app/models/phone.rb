# == Schema Information
#
# Table name: phones
#
#  id         :integer         not null, primary key
#  area       :string(255)     not null
#  carrier    :string(255)     not null
#  line       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Phone < ActiveRecord::Base
    validates :area, :presence => true, :length => { :is => 3 }, :numericality => true
    validates :carrier, :presence => true, :length => { :is => 3 }, :numericality => true
    validates :line, :presence => true, :length => { :is => 4 }, :numericality => true
end
