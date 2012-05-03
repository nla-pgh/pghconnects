# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  first           :string(255)     not null
#  middle          :string(255)
#  last            :string(255)     not null
#  birth_date      :date            not null
#  registered_at   :string(255)     not null
#  gender          :string(255)
#  ethnicity       :string(255)
#  clearance_level :string(255)     default("U"), not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_name       :string(255)
#  site_id         :integer
#

class User < ActiveRecord::Base

	attr_accessible :first, :middle, :last, :birth_date, :registered_at, :gender, :ethnicity,
									:user_name, :clearance_level, :site_id, :password, :password_confirmation,
									:password_digest, :as => :admin

	attr_accessible :first, :middle, :last, :birth_date, :registered_at, :gender, :ethnicity,
									:password, :password_confirmation

	validates :first, :presence => true
	validates :middle, :length => { :is => 1, :allow_nil => true, :allow_blank => true }
	validates :last, :presence => true
	validates :birth_date, :presence => true
	validates :registered_at, :presence => true
	validates :user_name, :uniqueness => { :allow_nil => true, :allow_blank => true }
	validates :password, :presence => { :if => Proc.new { |s| self.new_record? } }, :confirmation => true
	validates :password_confirmation, :presence => { :if => Proc.new { |s| self.new_record? } }

	belongs_to :site
	has_many :addresses, :dependent => :destroy
	has_many :phones, :dependent => :destroy
	has_many :emails, :dependent => :destroy
	has_many :educations, :dependent => :destroy
	has_many :work_histories, :dependent => :destroy
	has_many :sign_ups, :group => :event_id, :order => :site_id, :dependent => :destroy
	has_many :events, :through => :sign_ups, :group => :site_id, :dependent => :destroy

	has_secure_password

	before_save :generate_user_name

    def full_name
        "#{first} #{middle + ". " if not middle.blank?}#{last}"
    end

    def pretty_birth_date
        birth_date.to_s(:ordinal)
    end

    def full_ethnicity
        CONNECTS["form"]["ethnicity"].each do |full, abbr|
            return full if abbr == ethnicity
        end
    end
    
private
    def base_user_name
      "#{first.downcase[0,1]}#{last.downcase}_"
    end

    def generate_user_name
			if user_name
				user_name
			else
				size = User.count(:user_name, :conditions => "user_name LIKE \"#{base_user_name}%\"")
				self.user_name = "#{base_user_name}#{size}"
			end
    end
end
