# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  address    :string(255)
#  domain     :string(255)
#  root       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  full       :string(255)     not null
#

class Email < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A([\w+\-.]+)@([a-z\d\-.]+)\.([a-z]+)\z/i

    attr_accessible :address, :domain, :root, :full, :as => :admin
    attr_accessible :full

    validates :full, :presence => true, :format => { :with => VALID_EMAIL_REGEX, :message => "should be formatted as" }

    validates :root, :length => { :in => 2..3, :allow_blank => true, :allow_nil => true }

    belongs_to :user

    def regex_full
        match = VALID_EMAIL_REGEX.match(full)

        update_attributes({ :address => match[1], :domain => match[2], :root => match[3] }, :as => :admin)
    end
end
