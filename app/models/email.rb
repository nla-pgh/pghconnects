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
#  user_id    :integer
#

class Email < ActiveRecord::Base
    attr_accessible :address, :domain, :root

    validates :address, :presence => true
    validates :domain, :presence => true
    validates :root, :presence => true, :length => { :in => 2..3 }
    belongs_to :user
end
