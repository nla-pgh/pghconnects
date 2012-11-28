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
      size = User.count(:user_name, :conditions => "user_name LIKE '#{base_user_name}\_%'")
      user.user_name = "#{base_user_name}_#{size}"
    end
  end

  # Link user to a site
  before_save do |user|
    user.site = Site.find_by_abbr(user.registered_at)
  end

  ENABLE = "512"
  DISABLE = "2"

  # Add user to ldap
  before_create do |user|
    success = true
    Net::LDAP.open(CONNECTS[:ldap]) do |ldap|
      Rails.logger.info "Creating LDAP entry"
      dn = "CN=#{user.user_name},OU=#{user.site.abbr},OU=PC_Users,DC=user,DC=pghconnects,DC=org"

      attrs = {
        :distinguishedName => dn,
        :displayName => user.user_name,
        :givenName => user.first,
        :name => user.full_name,
        :sn => user.last,
        :sAMAccountName => user.user_name,
        :userPrincipalName => "#{user.user_name}@user.pghconnects.org",
        :userAccountControl => ENABLE,
        :objectClass => %w[top person organizationalPerson user],
        :userPassword => user.password,
        :cn => user.user_name
      }

      Rails.logger.debug "Attributes: #{attrs.inspect}"

      Rails.logger.info "DN: #{dn}"

      unless ldap.add(:dn => dn, :attributes => attrs)
        Rails.logger.info "#{ldap.get_operation_result.message}"
        Rails.logger.debug "Result: #{ldap.get_operation_result.code}"
        Rails.logger.debug "Message: #{ldap.get_operation_result.message}"
        success = false
      end
    end

    Rails.logger.info "SUCCESS: #{success}"

    unless success
      errors.add(:enable, "Error with LDAP connection.  Please notify administrators.")
    end

    return success
  end

  # Update attributes to ldap
  before_update do |user|
    success = true
    dn = "CN=#{user.user_name},OU=#{user.site.abbr},OU=PC_Users,DC=user,DC=pghconnects,DC=org"
    Rails.logger.info "Updating LDAP entry: #{dn}"

    Net::LDAP.open(CONNECTS[:ldap]) do |ldap|
      Rails.logger.info "User.password exists? #{!user.password.nil? && !user.password.blank?}"
      success = ldap.replace_attribute(dn, :userpassword, user.password) if user.password

      # Always change userAccountControl per update. TODO remonve unnecessary ldap access
      e = ldap.replace_attribute(dn, :userAccountControl, user.enable)

      unless e
        Rails.logger.info "Result: #{ldap.get_operation_result.code}"
        Rails.logger.info "Message: #{ldap.get_operation_result.message}"
        success = false
      end
    end

    unless success
      Rails.logger.info "Result: #{ldap.get_operation_result.code}"
      Rails.logger.info "Message: #{ldap.get_operation_result.message}"
      errors.add(:enable, "Error with LDAP connection.  Please notify administrators.")
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
