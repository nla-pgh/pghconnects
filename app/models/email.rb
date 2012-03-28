# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  address    :string(255)     not null
#  domain     :string(255)     not null
#  root       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer         not null
#

class Email < ActiveRecord::Base
    validates :address, :presence => true
    validates :domain, :presence => true
    validates :root, :presence => true, :length => { :in => 2..3 }
		validates :user_id, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
		belongs_to :user
end
