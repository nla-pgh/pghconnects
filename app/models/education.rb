# == Schema Information
#
# Table name: educations
#
#  id              :integer         not null, primary key
#  institution     :text
#  focus           :text
#  credential      :string(255)
#  school_id       :string(255)
#  finish_on       :date
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_id         :integer
#  education_level :string(255)
#

class Education < ActiveRecord::Base
    attr_accessible :institution, :focus, :credential, :school_id, :finish_on, :education_level, :as => :admin

    attr_accessible :institution, :focus, :credential, :school_id, :finish_on, :education_level

    belongs_to :user

    def pretty_finish_on
        finish_on.to_s(:long) if finish_on
    end
end
