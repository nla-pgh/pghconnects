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

require 'spec_helper'

describe "Users" do

		subject { user }

		let (:user) { factory_user(nil, nil) }

		it { should respond_to(:first) }
		it { should respond_to(:middle) }
		it { should respond_to(:last) }
		it { should respond_to(:birth_date) }
		it { should respond_to(:registered_at) }
		it { should respond_to(:gender) }
		it { should respond_to(:ethnicity) }
		it { should respond_to(:clearance_level) }
		it { should respond_to(:user_name) }

		describe "relationships" do
			it { should respond_to(:addresses) }
			it { should respond_to(:phones) }
			it { should respond_to(:emails) }
			it { should respond_to(:educations) }
			it { should respond_to(:work_histories) }

			it { should respond_to(:site) }

			context "with correct structure" do
				let(:user) { factory_user(:site_id, 0) }
				it { should respond_to(:site_id) }
				it { should be_valid }
			end
		end

		describe "have invalid attributes" do
			subject { user }

			describe "when first name is empty" do
				let(:user) { factory_user(:first, ' ') }
				it { should_not be_valid }
			end	

			describe "when last name is empty" do
				let (:user) { factory_user(:last, ' ') }
				it { should_not be_valid }
			end	

			describe "when birth date is empty" do
				let(:user) { factory_user(:birth_date, nil) }
				it { should_not be_valid }
			end

			describe "when registered at is empty" do
				let(:user) { factory_user(:registered_at, ' ') }
				it { should_not be_valid }
			end
		end
end
