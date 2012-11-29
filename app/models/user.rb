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
                  :password_digest, :enable, :as => :admin

  attr_accessible :first, :middle, :last, :birth_date, :registered_at, :gender, :ethnicity,
                  :password, :password_confirmation, :enable

  validates :first, :presence => true
  validates :middle, :length => { :is => 1, :allow_nil => true, :allow_blank => true }
  validates :last, :presence => true
  validates :birth_date, :presence => true
  validates :registered_at, :presence => true
  validates :user_name, :uniqueness => { :allow_nil => true, :allow_blank => true }

  validates :password,  :presence => { :if => Proc.new { |s| s.new_record? } }, 
                        :confirmation => { :unless => Proc.new { |s| s.password_confirmation.blank? } }
  validates :password_confirmation, :presence => { :if => Proc.new { |s| s.new_record? } }

  belongs_to :site
  has_many :addresses, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :emails, :dependent => :destroy
  has_many :educations, :dependent => :destroy
  has_many :work_histories, :dependent => :destroy
  has_many :sign_ups, :group => :event_id, :dependent => :destroy
  has_many :events, :through => :sign_ups, :dependent => :destroy

  has_secure_password

  # Generate user name as first initial lastname _ number
  # i.e.  John Smith => jsmith_0
  #       Jill Smith => jsmith_1
  before_save do |user|
    unless user.user_name
      base_user_name = "#{first.downcase[0,1]}#{last.downcase}"
      size = User.count(:user_name, :conditions => "user_name LIKE '#{base_user_name}!_%' ESCAPE '!'")
      user.user_name = "#{base_user_name}_#{size}"
    end
  end

  # Link user to a site
  before_save do |user|
    user.site = Site.find_by_abbr(user.registered_at)
  end

  #ENABLE = "#{0x00010000.to_i}" # Don't expire password
  ENABLE = "#{(0x00010000 + 0x00000200).to_i}" # normal account & non-expiring password
  DISABLE = "2" # disable account


  # Add user to ldap
  before_create do |user|
    dn = "CN=#{user.user_name},OU=#{user.site.abbr},OU=PC_Users,DC=user,DC=pghconnects,DC=org"
    success = true
    Net::LDAP.open(CONNECTS[:ldap]) do |ldap|
      Rails.logger.info "Creating LDAP entry"
      Rails.logger.info "DN: #{dn}"

      attrs = {
        :sAMAccountName => user.user_name,
        :cn => user.user_name
      }

      Rails.logger.inspect "Initial Attributes: #{attrs.inspect}"

      # Create the basic container first, then add attributes, if successful
      if ldap.add(:dn => dn, :attributes => attrs)
        other = {
          :distinguishedName => dn,
          :displayName => user.user_name,
          :givenName => user.first,
          :name => user.full_name,
          :sn => user.last,
          :userPrincipalName => "#{user.user_name}@user.pghconnects.org",
          :userAccountControl => ENABLE,
          :objectClass => %w[top person organizationalPerson user],
          :userPassword => user.password,
          :pwdLastSet => "129986070348365617",
        }

        other.each do |key, value|
          # TODO this could potentially create incomplete containers, fix?
          unless ldap.replace_attribute(dn, key, value)
            Rails.logger.info "Adding additional attributes"
            Rails.logger.info "Result: #{ldap.get_operation_result.code}"
            Rails.logger.info "Message: #{ldap.get_operation_result.message}"
          end
        end
      else
        Rails.logger.info "Result: #{ldap.get_operation_result.code}"
        Rails.logger.info "Message: #{ldap.get_operation_result.message}"
        errors.add(:enable, "Error with LDAP connection.  Please notify administrators.")
        success = false
      end
    end

    Rails.logger.info "SUCCESS: #{success}"

    return success
  end

  # Update attributes to ldap
  before_update do |user|
    dn = "CN=#{user.user_name},OU=#{user.site.abbr},OU=PC_Users,DC=user,DC=pghconnects,DC=org"
    success = true
    Rails.logger.info "Updating LDAP entry: #{dn}"

    Net::LDAP.open(CONNECTS[:ldap]) do |ldap|
      Rails.logger.info "Replacing password? #{!user.password.nil? && !user.password.blank?}"
      success = ldap.replace_attribute(dn, :userPassword, user.password) if user.password

      # Always change userAccountControl per update. TODO remonve unnecessary ldap access
      e = ldap.replace_attribute(dn, :userAccountControl, user.enable)

      unless e
        Rails.logger.info "Result: #{ldap.get_operation_result.code}"
        Rails.logger.info "Message: #{ldap.get_operation_result.message}"
        errors.add(:enable, "Error with LDAP connection.  Please notify administrators.")
        success = false
      end
    end

    return success
  end

  def enable=(v)
    @enable = v == 'true' ? ENABLE : DISABLE
  end

  def enable
    @enable || ENABLE
  end

  def full_name
    "#{first} #{middle + ". " if not middle.blank?}#{last}"
  end

  def pretty_birth_date
    birth_date.to_s(:ordinal)
  end

  def full_ethnicity
    CONNECTS[:form][:ethnicity].each do |full, abbr|
      return full if abbr == ethnicity
    end

    return nil
  end

  def admin?
    clearance_level != 'U'
  end

  def coordinator?
    clearance_level == 'C'
  end

  def manager?
    clearance_level == 'M'
  end

  def super?
    clearance_level == 'S'
  end

  def has_clearance_over(user)
    if super?
      return true
    elsif admin?
      return clearance_level >= user.clearance_level
    end

    return self == user
  end
end
