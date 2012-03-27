# == Schema Information
#
# Table name: addresses
#
#  id         :integer         not null, primary key
#  number     :integer         not null
#  street     :string(255)     not null
#  apt_fl     :string(255)
#  city       :string(255)     not null
#  state      :string(255)     not null
#  zip        :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Address < ActiveRecord::Base
end
