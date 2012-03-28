# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  first            :string(255)     not null
#  middle           :string(255)
#  last             :string(255)     not null
#  birth_date       :date            not null
#  registered_at    :string(255)     not null
#  gender           :string(255)
#  ethnicity        :string(255)
#  household_number :integer         not null
#  household_income :float           not null
#  education_level  :string(255)     not null
#  clearance_level  :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_name        :string(255)
#

require 'spec_helper'

describe "Users" do

		subject { user }

		describe "relationships" do
			let(:user) { User.new }
			it { should respond_to(:addresses) }
			it { should respond_to(:phones) }
			it { should respond_to(:emails) }
			it { should respond_to(:educations) }
			it { should respond_to(:work_histories) }

			it { should respond_to(:site) }
		end

		describe "have valid attributes" do
			let (:user) { factory_user(nil, nil) }

			it { should be_valid }

			describe "have necessary attributes" do
				it { should respond_to(:first) }
				it { should respond_to(:middle) }
				it { should respond_to(:last) }
				it { should respond_to(:birth_date) }
				it { should respond_to(:registered_at) }
				it { should respond_to(:gender) }
				it { should respond_to(:ethnicity) }
				it { should respond_to(:household_number) }
				it { should respond_to(:household_income) }
				it { should respond_to(:id) }
				it { should respond_to(:education_level) }
				it { should respond_to(:clearance_level) }
				it { should respond_to(:user_name) }
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

			describe "when household number is empty" do
				let(:user) { factory_user(:household_number, nil) }
				it { should_not be_valid }
			end

			describe "when household number is less than 1" do
				let(:user) { factory_user(:household_number, 0) }
				it { should_not be_valid }
			end

			describe "when household income is empty" do
				let(:user) { factory_user(:household_income, nil) }
				it { should_not be_valid }
			end

			describe "when household income is less than 0" do
				let(:user) { factory_user(:household_income, -1.0) }
				it { should_not be_valid }
			end

			describe "when education level is empty" do
				let(:user) { factory_user(:education_level, ' ') }
				it { should_not be_valid }
			end

			describe "when clearance level is empty" do
				let(:user) { factory_user(:clearance_level, ' ') }
				it { should_not be_valid }
			end

			describe "when user name is empty" do
				let(:user) { factory_user(:user_name, ' ') }
				it { should_not be_valid }
			end
		end
end
